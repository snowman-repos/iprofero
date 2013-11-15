# Timesheet model - just a factory that returns a resource object that
# interfaces with the REST API

angular.module("iprofero.timesheets").factory "Timesheets", [
	"$resource", ($resource) ->
		$resource "timesheets/:timesheetId",
			timesheetId: "@_id"
		,
			update:
				method: "PUT"
]

angular.module("iprofero.timesheets").factory "PersonTimesheets", [
	"$resource", ($resource) ->
		$resource "users/:userId/timesheets/:timesheetId",
			timesheetId: "@_id"
			userId: "@person"
		,
			update:
				method: "PUT"
]

angular.module("iprofero.timesheets").factory "ProjectTimesheets", [
	"$resource", ($resource) ->
		$resource "projects/:projectId/timesheets/:timesheetId",
			timesheetId: "@_id"
			projectId: "@project"
		,
			update:
				method: "PUT"
]