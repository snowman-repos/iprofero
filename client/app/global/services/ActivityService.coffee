# Activity model - just a factory that returns a resource object that
# interfaces with the REST API

angular.module("iprofero.system").factory "Activities", [
	"$resource", ($resource) ->
		$resource "activities/:activityId",
			activityId: "@_id"
		,
			update:
				method: "PUT"
]