# Job model - just a factory that returns a resource object that
# interfaces with the REST API

angular.module("iprofero.system").factory "Jobs", [
	"$resource", ($resource) ->
		$resource "jobs/:jobId",
			jobId: "@_id"
]