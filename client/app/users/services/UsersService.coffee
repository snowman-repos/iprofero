# User model - just a factory that returns a resource object that
# interfaces with the REST API

angular.module("iprofero.users").factory "Users", [
	"$resource", ($resource) ->
		$resource "users/:userId",
			userId: "@_id"
		,
			update:
				method: "PUT"
]