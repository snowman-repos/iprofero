# Main app model - this provides a global user resource.

angular.module("iprofero.system").factory "Global", [ ->
	@._data =
		user: window.user
		authenticated: !!window.user
]

underscore = angular.module("underscore", [])
underscore.factory "_", ->
	window._