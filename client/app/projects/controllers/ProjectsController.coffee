# Projects module controller

angular.module("iprofero.projects").controller "ProjectsController", [
	"$scope",
	"$routeParams",
	"$location",
	"Global",
	"Projects",
	"Users",
	"Technologies"
	($scope, $routeParams, $location, Global, Projects, Users, Technologies) ->
		$scope.global = Global
		$scope.isAdmin = ($scope.global.user.role == "admin")

		# Wait until the project model has been retrieved
		$scope.$watch('project', ->

			if $scope.project?

				$scope.people = []
				$scope.peopleValues = {}
				$scope.participants = []

				# Need to get all users
				Users.query "", (users) ->
					$scope.people = users
					for person in $scope.people

						# need to see who is already participating
						personIsParticipating = person._id in $scope.project.participants
						$scope.peopleValues[person._id] = personIsParticipating
						if personIsParticipating then $scope.participants.push person
						if person._id is $scope.project.account_manager.id
							$scope.account_manager = person
						if person._id is $scope.project.project_manager.id
							$scope.project_manager = person
		)

		$scope.newTechnologies = []
		$scope.technologySuggestions = []

		# Get all technologies
		Technologies.query "", (technologies) ->
			for technology in technologies
				$scope.technologySuggestions.push(technology.name)

		# Add new technology when tags input is updated
		$scope.tagsUpdated = (field) ->
			if field is "technologies" and $scope.project?
				$scope.project.technologies = $scope[field]
				$scope.newTechnologies = $.grep($scope.project.technologies, (el) ->
					$.inArray(el, $scope.technologySuggestions) is -1
				)

		# Check the user in the multiselect list can be toggled
		# If the user in the list is selected as the account / project
		# manager, then they must be participating in the project and
		# therefore can't be toggled off
		$scope.okToToggle = (id) ->
			$scope.project.account_manager !=
			 id && $scope.project.project_manager != id

		# Set the parent object on the model when the checkbox is changed
		$scope.$watch('hasparent', ->
			if $scope.hasparent isnt true and $scope.project?
				$scope.project.parent.id = ""
				$scope.project.parent.name = ""
		)

		# Set the parent project and add this project to the
		# parent's list of sub projects
		$scope.setParentage = ->

			if $scope.project.parent.id != ""
	
				Projects.get
					projectId: $scope.project.parent.id
				, (parent) ->
	
					# make sure this project is in the parent project's
					# sub projects list
					if $scope.project._id not in parent.sub_projects
						parent.sub_projects.push(
							id: $scope.project._id
							name: $scope.project.name
						)

						parent.$update ->

			else

				# find projects with this project in subprojects and remove this
				#  project from list
	
				Projects.query "", (potential_parent_projects) ->
					for project in potential_parent_projects
	
						issubproject = false
	
						for subproject in project.sub_projects
	
							if subproject.id is $scope.project._id
								issubproject = true
								break
	
						if issubproject
	
							project.sub_projects =
							 project.sub_projects.filter (subproject) ->
							 	subproject.id is not $scope.project._id
	
							project.$update ->

		# Add list of participants and add this project to each user's
		# projects list
		$scope.setParticipants = ->

			$scope.project.participants = []

			for person in $scope.people

				# check if the project is in the person's project list
				in_persons_list = $scope.project._id in person.projects
				person_updated = false

				if $scope.peopleValues[person._id]
					# this person is participating in this project
					# so add them to the project's participants list
					# and ensure the project is in their projects list

					$scope.project.participants.push person._id

					if !in_persons_list
						person.projects.push
							id: $scope.project._id
							name: $scope.project.name
							client: $scope.project.client
						person_updated = true

				else
					# this person is not participating in this project
					# so don't add them to the project's participants list
					# and ensure the project is not in their projects list
					if in_persons_list
						person.projects =
						 person.projects.filter (project) -> project is not $scope.project._id
						person_updated = true

				if person_updated
					person.$update (response) ->

			if $scope.project.participants.length != 0
				$scope.project.$update ->

				# $scope.$apply( ->
				# 	person.$update (something) ->
				# 		console.log something
				# )

		# Create new project
		$scope.create = ->

			@name = ""
			@agency = ""
			@client = ""
			@description = ""
			@parent =
				id: ""
				name: ""
			@account_manager =
				id: ""
				name: ""
			@project_manager =
				id: ""
				name: ""
			@sub_projects = []
			@feedback = {}
			@participants = []
			@technologies = []
			@github = ""
			@urls =
				development: ""
				testing: ""
				staging: ""
				production: ""
			@quote = ""
			@purchase_order = ""
			@invoice = ""
			@revenue =
				currency: "yuan"
				amount: 0
			@cost = 0
			@profit = 0

			$scope.project = new Projects(
				name: @name
				agency: $scope.global.user.agency
				client: @client
				description: @description
				parent: @parent
				account_manager: @account_manager
				project_manager: @project_manager
				sub_projects: @sub_projects
				feedback: @feedback
				participants: @participants
				technologies: @technologies
				github: @github
				urls: @urls
				quote: @quote
				purchase_order: @purchase_order
				invoice: @invoice
				revenue: @revenue
				cost: @cost
				profit: @profit
			)

			$scope.find()

		# Save project model
		$scope.save = ->
			$scope.saveNewTechnologies()
			$scope.project.$save (response) ->
				if !response.errors?
					$scope.project = response
					$scope.setParticipants()
					$scope.setParentage()
					$location.path "projects/" + response._id
				else
					console.log response.errors.name.message

		# Delete project, remove it from any partipants' projects lists,
		# cut off any children projects, and remove from any parent projects'
		# subprojects lists.
		$scope.remove = ->
			project = $scope.project

			# find users with this project in their projects list
			# and remove the project
			for participant in $scope.participants
				participant.projects =
				 participant.projects.filter (proj) -> proj.id != project._id
				participant.$update (response) ->

			# Go through all projects and check if this project is that
			# project's parent. If so remove the parent.
			Projects.query "", (projects) ->
				for proj in projects
					if proj.parent.id == project._id
						proj.parent.id = ""
						proj.parent.name = ""
						proj.$update (response) ->

			# if has parent then remove from parent's subprojects list
			if project.parent.id? && project.parent.id != ""
				Projects.get projectId: project.parent.id, (parent) ->
					parent.sub_projects =
					 parent.sub_projects.filter (proj) -> proj.id != project._id
					parent.$update (response) ->
						# remove from db
						project.$remove (response) ->
							if response.$resolved
								
								if $scope.projects?
									$scope.projects =
										$scope.projects.filter (proj) -> proj._id != project._id
								
								# go back to the projects page
								$location.path "projects/"
			else
				# remove from db
				project.$remove (response) ->
					if response.$resolved
						
						if $scope.projects?
							$scope.projects =
								$scope.projects.filter (proj) -> proj._id != project._id
						
						# go back to the projects page
						$location.path "projects/"

		# Update project model
		$scope.update = ->
			$scope.setParticipants()
			$scope.setParentage()
			project = $scope.project
			project.updated = [] unless project.updated
			project.updated.push new Date().getTime()
			project.$update ->
				$location.path "projects/" + project._id

			$scope.saveNewTechnologies()

		# Save new technologies from tags input
		$scope.saveNewTechnologies = ->

			for newTechnology in $scope.newTechnologies
				technology = new Technologies(
					name: newTechnology
				)
				technology.$save (response) ->

		# Update single property on the model - do we need this?
		$scope.updateSingleProperty = (property, value) ->
			project = $scope.project
			$scope.project[property] = value
			project[property] = value
			project.updated = [] unless project.updated
			project.updated.push new Date().getTime()
			project.$update (response) ->
				# $location.path "projects/" + project._id

		# Fetch all projects according to query
		$scope.find = (query) ->
			Projects.query query, (projects) ->
				$scope.projects = projects
				console.log $scope.projects.length
				$scope.predicate = "name"
				$scope.reverse = false

		# Fetch single project
		$scope.findOne = ->
			Projects.get
				projectId: $routeParams.projectId
			, (project) ->
				$scope.project = project
				if $scope.project.parent.id != ""
					$scope.hasparent = true

		# Edit page
		$scope.edit = ->
			$scope.find()
			$scope.findOne()

		# View page
		$scope.view = ->
			$scope.findOne()
]