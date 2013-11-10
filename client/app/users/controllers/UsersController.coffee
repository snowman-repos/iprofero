# Users module controller

angular.module("iprofero.users").controller "UsersController", [
	"$scope",
	"$routeParams",
	"$location",
	"Global",
	"Users",
	"Projects",
	"Skills",
	"$http"
	($scope, $routeParams, $location, Global, Users, Projects, Skills, $http) ->
		$scope.global = Global
		$scope.loggedInUser = $scope.global.user
		$scope.isAdmin = ($scope.global.user.role == "admin")

		$scope.skills = []
		$scope.skillSuggestions = []
		Skills.query "", (skills) ->
			for skill in skills
				$scope.skillSuggestions.push(skill.name)

		# Add skill from the tags input
		$scope.tagsUpdated = (field) ->
			if $scope.user
				$scope.user.skills = $scope.skills
				$scope.updateSingleProperty('skills', $scope.skills)
				$scope.newSkills = $.grep($scope.user.skills, (el) ->
					$.inArray(el, $scope.skillSuggestions) is -1
				)

		# Delete user
		$scope.remove = ->
			# you can't delete yourself!
			if $scope.user._id != $scope.loggedInUser._id
				user = $scope.user
	
				# remove user from projects' participants lists
				for project in $scope.projects
					project.participants =
					 project.participants.filter (participant) -> participant != user._id
					project.$update (response) ->
	
				# delete from DB
				user.$remove (response) ->
					if response.$resolved
						# go back to the users page
						$location.path "people/"

		# Update entire user profile
		$scope.update = ->
			user = $scope.user
			user.updated = [] unless user.updated
			user.updated.push new Date().getTime()
			user.$update ->
				$location.path "users/" + user._id

		# Update single property - do we need this?
		$scope.updateSingleProperty = (property, value) ->
			user = $scope.user
			user[property] = value
			user.updated = [] unless user.updated
			user.updated.push new Date().getTime()
			user.$update ->
				# $location.path "users/" + user._id

		# Fetch all users
		$scope.find = (query) ->
			Users.query query, (users) ->
				$scope.users = users
				$scope.predicate = "name"
				$scope.reverse = false

		# Fetch single user
		$scope.findOne = ->
			Users.get
				userId: $routeParams.userId
			, (user) ->
				$scope.setUser(user)

		# Fetch profile of logged in user
		$scope.findMe = ->
			Users.get
				userId: $scope.loggedInUser._id
			, (user) ->
				$scope.setUser(user)

		# Retrieve data relating to user
		$scope.setUser = (user) ->
			$scope.user = user
			$scope.skills = $scope.user.skills
			startdate = $scope.user.employment_period.start
			enddate = $scope.user.employment_period.end
			$scope.user.employment_period.start = moment(startdate).format("MMMM, YYYY")
			$scope.user.employment_period.end = moment(enddate).format("MMMM, YYYY")
			$scope.isLoggedInUser = ($scope.loggedInUser._id == user._id)
			# Projects.query "", (projects) ->
			# 	$scope.projects =
			# 	 projects.filter (project) -> project._id in $scope.user.projects

]