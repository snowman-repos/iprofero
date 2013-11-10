# Project model - just a factory that returns a resource object that
# interfaces with the REST API

angular.module("iprofero.projects").factory "Projects", [
	"$resource", ($resource) ->
		$resource "projects/:projectId",
			projectId: "@_id"
		,
			update:
				method: "PUT"
]