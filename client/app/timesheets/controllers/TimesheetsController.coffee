# Timesheets module controller

angular.module("iprofero.timesheets").controller "TimesheetsController", [
	"$scope",
	"Global",
	"Timesheets",
	"PersonTimesheets",
	"ProjectTimesheets",
	"Users",
	"Projects",
	"Activities",
	"Stopwatch",
	"TimesheetPreferences"
	($scope,
	Global,
	Timesheets,
	PersonTimesheets,
	ProjectTimesheets,
	Users,
	Projects,
	Activities,
	Stopwatch,
	TimesheetPreferences) ->

		$scope.user = Global.user
		$scope.Stopwatch = Stopwatch

		# ------------------
		# Setup
		# ------------------

		# Input preferences
		$scope.prefs =
			logType: "form"

		# Prepare new time log
		$scope.resetNewTimeLog = ->
			$scope.newtimelog =
				time: 0
				project: TimesheetPreferences.get "project"
				activity: TimesheetPreferences.get "activity"
				date: new Date(moment())
				startdate: new Date(moment())
				enddate: new Date(moment())
				hours: TimesheetPreferences.get "hours"
				comment: ""

		# Prepare model for new timelog
		$scope.resetNewTimeLog()

		# Get Projects
		$scope.projectNames = []
		for project in $scope.user.projects
			$scope.projectNames[project.id] = project.name
			if project.id == $scope.newtimelog.project
				$scope.project = project

		if $scope.project is null or $scope.project == ""
			$scope.project = $scope.user.projects[0]
			$scope.newtimelog.project = $scope.user.projects[0].id
			$scope.setProject()

		# Fetch all Activities
		$scope.activityNames = []
		Activities.query "", (activities) ->
			$scope.activities = activities
			for activity in activities
				$scope.activityNames[activity._id] = activity.name
				if activity._id == $scope.newtimelog.activity
					$scope.activity = activity

		if $scope.activity is null or $scope.activity == ""
			$scope.activity = $scope.activities[0]
			$scope.newtimelog.project = $scope.activities[0].id
			$scope.setActivity()

		# Fetch my timelogs
		$scope.myTimelogs = []
		PersonTimesheets.get
				userId: $scope.user._id
			, (timelogs) ->
				$scope.myTimelogs = timelogs
				$scope.hoursThisWeek = 12
				$scope.activeProjects = 3

		# ------------------
		# Preferences
		# ------------------

		# The method of recording the time
		# from local storage if possible
		$scope.prefs.logType = TimesheetPreferences.get "logType"
		if $scope.prefs.logType == ""
			$scope.prefs.logType = "form"
			$scope.setLogType()

		# The method of recording the date from local storage
		# if possible. LS returns string so need to do conversion.
		# Default is false.
		if (TimesheetPreferences.get "dateRange").toLocaleLowerCase().trim() == "true"
			$scope.prefs.dateRange = true
		else
			$scope.prefs.dateRange = false
		if !$scope.prefs.dateRange?
			$scope.prefs.dateRange = false

		# Ensure the time stays the same if the user switches between
		# the textbox and the slider input method. The slider records
		# seconds while the textbox records hours, so need conversion.
		$scope.$watch("newtimelog.hours", ->
			$scope.valid = $scope.newtimelog.hours > 0 and $scope.newtimelog.hours < 24
			if $scope.valid
				$scope.newtimelog.time = $scope.newtimelog.hours * 60 * 60
				$scope.setHours()
		)
		$scope.$watch("newtimelog.time", ->
			$scope.newtimelog.hours = $scope.newtimelog.time / 60 / 60
		)

		# Update the new timelog model when the user selects a new
		# project or activity
		$scope.$watch("project", ->
			if $scope.project?
				$scope.newtimelog.project = $scope.project.id
				$scope.setProject()
		)
		$scope.$watch("activity", ->
			if $scope.activity
				$scope.newtimelog.activity = $scope.activity._id
				$scope.setActivity()
		)

		# Format the date from the date picker so that it shows nicely
		# in the input element
		$scope.$watch("newtimelog.date", ->
			if moment($scope.newtimelog.date).format("DD/MM/YYYY") == moment().format("DD/MM/YYYY")
				$scope.date = "today"
			else if moment($scope.newtimelog.date).format("DD/MM/YYYY") == moment().subtract('days', 1).format("DD/MM/YYYY")
				$scope.date = "yesterday"
			else if moment($scope.newtimelog.date).isSame(moment(), 'week')
				$scope.date = moment($scope.newtimelog.date).format("dddd")
			else
				$scope.date = moment($scope.newtimelog.date).format("DD MMM")
		)
		$scope.$watch("newtimelog.startdate", ->
			if moment($scope.newtimelog.startdate).format("DD/MM/YYYY") == moment().format("DD/MM/YYYY")
				$scope.startdate = "today"
			else if moment($scope.newtimelog.startdate).format("DD/MM/YYYY") == moment().subtract('days', 1).format("DD/MM/YYYY")
				$scope.startdate = "yesterday"
			else if moment($scope.newtimelog.startdate).isSame(moment(), 'week')
				$scope.startdate = moment($scope.newtimelog.startdate).format("dddd")
			else
				$scope.startdate = moment($scope.newtimelog.startdate).format("DD MMM")
		)
		$scope.$watch("newtimelog.enddate", ->
			if moment($scope.newtimelog.enddate).format("DD/MM/YYYY") == moment().format("DD/MM/YYYY")
				$scope.enddate = "today"
			else if moment($scope.newtimelog.enddate).format("DD/MM/YYYY") == moment().subtract('days', 1).format("DD/MM/YYYY")
				$scope.enddate = "yesterday"
			else if moment($scope.newtimelog.enddate).isSame(moment(), 'week')
				$scope.enddate = moment($scope.newtimelog.enddate).format("dddd")
			else
				$scope.enddate = moment($scope.newtimelog.enddate).format("DD MMM")
		)

		$scope.validate = ->
			$scope.$apply(
				$scope.valid = true
			)

		$scope.invalidate = ->
			$scope.$apply(
				$scope.valid = false
			)

		$scope.setLogType = ->
			TimesheetPreferences.set "logType", $scope.prefs.logType

		$scope.setProject = ->
			TimesheetPreferences.set "project", $scope.newtimelog.project

		$scope.setActivity = ->
			TimesheetPreferences.set "activity", $scope.newtimelog.activity

		$scope.setHours = ->
			TimesheetPreferences.set "hours", $scope.newtimelog.hours

		$scope.setDateFormat = ->
			TimesheetPreferences.set "dateRange", $scope.prefs.dateRange

		# ------------------
		# Save
		# ------------------

		$scope.logTime = ->

			if $scope.prefs.logType == "timer"

				if Stopwatch.data.value != 0 and
					$scope.newtimelog.project != "" and
					$scope.newtimelog.activity != "" and
					$scope.newtimelog.date != ""

						# save
						
						$scope.newtimelog.time = Stopwatch.data.value

						# Save a single timesheet
						$scope.save($scope.newtimelog)

						# Prepare model for new timelog
						$scope.resetNewTimeLog()
						$scope.newtimelog.hours = 0
						Stopwatch.reset()

				else
					console.log "can't save - incomplete data"
					console.log "Time: " + Stopwatch.data.value
					console.log $scope.newtimelog

			else

				if $scope.newtimelog.project == "" or
					$scope.newtimelog.activity == "" or
					$scope.newtimelog.date == "" or
					$scope.newtimelog.time == 0 or
					!$scope.valid

						console.log "can't save - incomplete data"
						console.log $scope.newtimelog
				else

					if $scope.prefs.dateRange is false

						# Save a single timesheet
						$scope.save($scope.newtimelog)

						# Prepare model for new timelog
						$scope.resetNewTimeLog()
						$scope.newtimelog.hours = 0

					else

						# Save a single time sheet for each date in range

						start = moment($scope.newtimelog.startdate)
						end = moment($scope.newtimelog.enddate)
						while start.isBefore(end)

							$scope.newtimelog.date = new Date(start)

							# Save a single timesheet
							$scope.save($scope.newtimelog)

							start.add("days", 1)

						# Prepare model for new timelog
						$scope.resetNewTimeLog()
						$scope.newtimelog.hours = 0

		$scope.newTimesheet = (timesheet) ->
			newtimesheet = new Timesheets(
				activity: timesheet.activity
				agency: $scope.user.agency
				date: timesheet.date
				hours: timesheet.hours
				person: $scope.user._id
				project: timesheet.project
				comment: timesheet.comment
			)

		$scope.save = (timesheet) ->
			newtimesheet = $scope.newTimesheet(timesheet)
			console.log "SAVING:"
			console.log newtimesheet
			console.log "------------"
			newtimesheet.$save (response) ->
				# Add newly added timelog to list

]