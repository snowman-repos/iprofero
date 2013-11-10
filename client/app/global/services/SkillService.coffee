# Skill model - just a factory that returns a resource object that
# interfaces with the REST API

angular.module("iprofero.system").factory "Skills", [
	"$resource", ($resource) ->
		$resource "skills/:skillId",
			skillId: "@_id"
]