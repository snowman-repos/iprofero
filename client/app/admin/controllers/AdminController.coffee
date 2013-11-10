# Main controller for the admin module

angular.module("iprofero.admin").controller "AdminController", [
	"$scope",
	"Global",
	"$location",
	"Skills",
	"Technologies",
	"Teams",
	"Jobs",
	"Activities"
	($scope, Global, $location, Skills, Technologies, Teams, Jobs, Activities) ->

		# Ensure the user is authorised
		if Global.user.role is not "admin"
			$location.path "/"

		# Settings page
		$scope.settings = ->

			# Fetch all skills
			Skills.query "", (skills) ->
				$scope.skills = skills

			# Fetch all technologies
			Technologies.query "", (technologies) ->
				$scope.technologies = technologies

			# Fetch all teams
			Teams.query "", (teams) ->
				$scope.teams = teams

			# Fetch all Jobs
			Jobs.query "", (jobs) ->
				$scope.jobs = jobs

			# Fetch all Activities
			Activities.query "", (activities) ->
				$scope.activities = activities

			$scope.new_activity =
				agency: Global.user.agency
				name: ""
				billable: false
				rate: 0
				parent:
					id: ""
					name: ""
				isparent: false

		# Add new job
		$scope.addJob = (newJob) ->
			if newJob !=""
				job = new Jobs(
					title: newJob
				)
				job.$save (response) ->
					if !response.errors?
						$scope.jobs.push response
					else
						console.log response.errors.title.message

					$scope.newJob = ""

		# Remove job
		$scope.removeJob = (id) ->
			Jobs.get
				jobId: id
			, (job) ->
				job.$remove()
				$scope.jobs = $scope.jobs.filter (j) -> j._id != job._id

		# Add new team
		$scope.addTeam = (newTeam) ->
			if newTeam !=""
				team = new Teams(
					name: newTeam
				)
				team.$save (response) ->
					if !response.errors?
						$scope.teams.push response
					else
						console.log response.errors.name.message

					$scope.newTeam = ""

		# Remove team
		$scope.removeTeam = (id) ->
			Teams.get
				teamId: id
			, (team) ->
				team.$remove()
				$scope.teams = $scope.teams.filter (t) -> t._id != team._id

		# Add new technology
		$scope.addTechnology = (newTechnology) ->
			if newTechnology != ""
				technology = new Technologies(
					name: newTechnology
				)
				technology.$save (response) ->
					if !response.errors?
						$scope.technologies.push response
					else
						console.log response.errors.name.message

					$scope.newTechnology = ""

		# Remove technology
		$scope.removeTechnology = (id) ->
			Technologies.get
				technologyId: id
			, (technology) ->
				technology.$remove()
				$scope.technologies =
				 $scope.technologies.filter (j) -> j._id != technology._id

		# Add new skill
		$scope.addSkill = (newSkill) ->
			if newSkill != ""
				skill = new Skills(
					name: newSkill
				)
				skill.$save (response) ->
					if !response.errors?
						$scope.skills.push response
					else
						console.log response.errors.name.message

					$scope.newSkill = ""

		# Remove skill
		$scope.removeSkill = (id) ->
			Skills.get
				skillId: id
			, (skill) ->
				skill.$remove()
				$scope.skills = $scope.skills.filter (j) -> j._id != skill._id

		# Add new activity
		$scope.addActivity = ->

			if $scope.new_activity.name != ""

				activity = new Activities(
					agency: $scope.new_activity.agency
					name: $scope.new_activity.name
					billable: $scope.new_activity.billable
					rate: $scope.new_activity.rate
					isparent: $scope.new_activity.isparent
					parent:
						id: $scope.new_activity.parent.id
						name: $scope.new_activity.parent.name
				)
				
				activity.$save (response) ->
					if !response.errors?

						$scope.activities.push response
	
						if response.parent.id? and response.parent.id != ""
							for activity in $scope.activities
								if activity._id == response.parent.id
									activity.isparent = true
									$scope.update(activity)

					else
						console.log response.errors.name.message
						
					$scope.new_activity.name = ""
					$scope.new_activity.billable = false
					$scope.new_activity.rate = 0
					$scope.new_activity.isparent = false
					$scope.new_activity.parent =
						id: ""
						name: ""

		# Update activity
		$scope.update = (activity) ->
			activity.$update (response) ->
				if response.errors?
					console.log response.errors

		$scope.updateParent = (child, parent) ->

			if child.parent.id? and child.parent.id != ""
				oldparent = child.parent.id

			Activities.get
				activityId: child._id
			, (activity) ->
				activity.parent.id = parent._id
				activity.parent.name = parent.name
				$scope.update activity

			Activities.get
				activityId: parent._id
			, (activity) ->
				activity.isparent = true
				$scope.update activity

			if oldparent?
				$scope.setActivityParentage()

		$scope.setActivityParentage = ->

			# go through all activities and find out whether it's a parent
			for activity in $scope.activities
				updated = false
				if activity.isparent
					childfound = false
					for otheractivity in $scope.activities
						if otheractivity.parent.id == activity._id
							childfound = true
					if !childfound
						activity.isparent = false
						updated = true
				else
					for otheractivity in $scope.activities
						if otheractivity.parent.id == activity._id
							activity.isparent = true
							updated = true

				if updated
					$scope.update activity


		# Remove activity
		$scope.removeActivity = (id) ->

			Activities.get
				activityId: id
			, (activity) ->
				activity.$remove()
				$scope.activities = $scope.activities.filter (j) -> j._id != activity._id
				
				# go through all activities and find out if parent is still there
				for otheractivity in $scope.activities
					updated = false
					if otheractivity.parent.id == id
						otheractivity.parent.id = ""
						otheractivity.parent.name = ""
						updated = true
					if updated
						$scope.update otheractivity

				$scope.setActivityParentage()
]