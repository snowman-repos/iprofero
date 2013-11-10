# Main controller for the index / welcome page - should be broken up

angular.module("iprofero.system").controller "IndexController", [
	"$scope",
	"Global",
	"Jobs",
	"Skills",
	"Users",
	"Projects",
	"Teams",
	"$filter",
	"$location"
	($scope, Global, Jobs, Skills, Users, Projects, Teams, $filter, $location) ->
		$scope.global = Global
		$scope.user = $scope.global.user

		required_fields = [
			"email"
		,
			"contact": ["telephone"]
		,
			"job_title"
		]
		
		# listen for updates from the date picker
		$scope.$watch('date', ->
			$scope.user.employment_period.start = $scope.date
		)

		if $scope.user?
			for field in required_fields
				if typeof field is "object"
					for key, value of field
						for v in value
							if $scope.user[key][v] == "" or !$scope.user[key][v]?
								console.log "missing field: " + v
								if $location.path() != "/welcome"
									$location.path "welcome"
				else
					if $scope.user[field] == "" or !$scope.user[field]?
						console.log "missing field: " + field
						if $location.path() != "/welcome"
							$location.path "welcome"

		# Welcome page
		$scope.welcome = ->

			$scope.skills = []
			$scope.skillSuggestions = []
			# get all skills
			Skills.query "", (skills) ->
				for skill in skills
					$scope.skillSuggestions.push(skill.name)

			# Get all job titles
			Jobs.query "", (jobs) ->
				$scope.jobs = jobs

			# Get all teams
			Teams.query "", (teams) ->
				$scope.teams = teams

			# Fetch the correct user model for the logged in user
			$scope.getUser( ->

				if $scope.user.provider != "local"
					$scope.populateDataFromSNS()
			

				# Get all projects
				$scope.projects = []
				$scope.projectsValues = {}
				Projects.query "", (projects) ->
					$scope.projects = projects

					for project in $scope.projects
	
						# need to see who is already participating
						participatingInProject = $scope.user._id in project.participants
						$scope.projectsValues[project._id] = participatingInProject


				# Set default avatar if one not set
				if $scope.user.avatar == ""
					$scope.user.avatar = "http://gravatar.com/avatar/" + md5($scope.user.email)

				# Get user's current skills
				$scope.skills = $scope.user.skills

				# Determine which stage of the welcome process they should be at
				$scope.step = 1
				$scope.step = 4 if ($scope.user.projects.length == 0)
				$scope.step = 3 if ($scope.user.skills.length == 0)
				if (!$scope.user.salary? || !$scope.user.employment_period.start?)
					$scope.step = 2
				# $scope.step = 1 if (!$scope.user.email? ||
				# 	 !$scope.user.contact.telephone? || !$scope.user.job_title?)
			
				# Format start date
				$scope.$watch('user.employment_period.start', ->
					$scope.user.employment_period.start =
						moment($scope.user.employment_period.start).format("MMMM, YYYY")
				)
			)

		# Add the user to the participants lists of the projects in which they
		# are participating and ensure they are not in any lists they shouldn't
		# be in.
		$scope.setParticipation = ->

			for project in $scope.projects

				projectUpdated = false
				in_project_participants_list = $scope.user._id in project.participants

				# check if the person is participating in this project

				if $scope.projectsValues[project._id]

					# add the project to the user's projects list
					$scope.user.projects.push(
						id: project._id
						name: project.name
						client: project.client
					)

					# if the user is not in the project's participants list
					# then add it
					if not in_project_participants_list
						project.participants.push $scope.user._id
						projectUpdated = true

				else

					# ensure the project is not in the user's projects list
					$scope.user.projects =
					 $scope.user.projects.filter (proj) -> proj.id != project._id

					# if the user is in the project's participants list
					# then remove it
					if in_project_participants_list
						project.participants =
						 project.participants.filter (person) -> person != $scope.user._id
						projectUpdated = true

				if projectUpdated
					project.$update ->

				# $scope.$apply( ->
				# 	project.$update ->
				# )

		# Proceed through welcome process
		$scope.next = ->

			# Add user to projects and update profile
			$scope.setParticipation()
			$scope.updateUser()

			# Redirect to profile page after completing welcome process
			if $scope.step == 4 then $location.path "me"

			$scope.$apply(-> $scope.step++)

			# see if there are any new skills to add
			if $scope.step == 4 then for newSkill in $scope.newSkills
				skill = new Skills(
					name: newSkill
				)
				skill.$save (response) ->

		# Update user model
		$scope.updateUser = ->
			user = $scope.user
			user.updated = [] unless user.updated
			user.updated.push new Date().getTime()
			user.$update ->

		$scope.getUser = (callback) ->
			Users.get userId: $scope.user._id, (user) ->
				$scope.user = user
				callback()

		$scope.populateDataFromSNS = ->
	
			# if $scope.user.provider == "facebook"
			# 	facebook = $scope.user.facebook
			# 	$scope.user.employment_period.start = facebook.work[0].start_date
			# 	$scope.user.job_title = facebook.work[0].position.name
			# 	$scope.user.website = facebook.link
			# 	$scope.user.avatar = "https://graph.facebook.com/"+facebook.id+"/picture"
			
			# if $scope.user.provider == "twitter"
			# 	twitter = $scope.user.twitter
			# 	$scope.user.website = twitter.entities.url.urls.expanded_url
			# 	$scope.user.avatar = twitter.profile_image_url
	
			# if $scope.user.provider == "google"
			# 	google = $scope.user.google
			# 	$scope.user.avatar = google.picture
	
			# if $scope.user.provider == "github"
			# 	github = $scope.user.github
			# 	$scope.user.avatar = github.avatar_url
			# 	$scope.user.contact =
			# 		github: github.login
			# 		email: github.emails[0].value
	
			# if $scope.user.provider == "weibo"
			# 	weibo = $scope.user.weibo
			# 	$scope.user.avatar = weibo.profileImageUrl
	
			# if $scope.user.active
			# 	$scope.user.employment_period.end = Date.now()

			# $scope.user.$update (user) ->
			# 	$scope.user = user

		# Add new skill when tags input updated
		$scope.tagsUpdated = (field) ->
			$scope.user.skills = $scope.skills
			$scope.newSkills = $.grep($scope.user.skills, (el) ->
				$.inArray(el, $scope.skillSuggestions) is -1
			)
]