# Technology model - just a factory that returns a resource object that
# interfaces with the REST API

angular.module("iprofero.system").factory "Technologies", [
	"$resource", ($resource) ->
		$resource "technologies/:technologyId",
			technologyId: "@_id"
]