# Team model - just a factory that returns a resource object that
# interfaces with the REST API

angular.module("iprofero.system").factory "Teams", [
	"$resource", ($resource) ->
		$resource "teams/:teamId",
			teamId: "@_id"
]