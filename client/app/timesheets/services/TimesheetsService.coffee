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