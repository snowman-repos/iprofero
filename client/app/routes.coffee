window.app.config [ "$routeProvider", ($routeProvider) ->

	# Client-side routes

	$routeProvider.when("/timesheets",
		templateUrl: "views/timesheets/index.html"
	).when("/projects",
		templateUrl: "views/projects/list.html"
	).when("/projects/new",
		templateUrl: "views/projects/create.html"
	).when("/projects/:projectId",
		templateUrl: "views/projects/view.html"
	).when("/projects/edit/:projectId",
		templateUrl: "views/projects/edit.html"
	).when("/people",
		templateUrl: "views/users/list.html"
	).when("/people/:userId",
		templateUrl: "views/users/view.html"
	).when("/profile/:userId",
		templateUrl: "/views/users/view.html"
	).when("/me",
		templateUrl: "views/users/profile.html"
	).when("/dashboard",
		templateUrl: "views/dashboard.html"
	).when("/welcome",
		templateUrl: "views/welcome.html"
	).when("/",
		templateUrl: "views/index.html"
	).when("/admin/settings",
		templateUrl: "views/admin/settings.html"
	).when("/admin/reports",
		templateUrl: "views/admin/reports.html"
	).otherwise redirectTo: "/"
]

# Prefix all routes with the bang
# this shouldn't be needed with html5 mode true,
# but because the api is on the same server, the routes
# can't be shared.
window.app.config [ "$locationProvider", ($locationProvider) ->
	$locationProvider.html5Mode(false).hashPrefix('!')
]

# Route interceptors
window.app.run ($rootScope, $location, $cookieStore, Global) ->

	routesThatDontRequireAuth = [
		'/profile'
		'/signin'
	]

	routesThatRequireAdmin = [
		'/admin/reports'
		'/projects/create'
		'/projects/edit'
	]

	checkAuth = (route) ->
		_.find routesThatDontRequireAuth, (noAuthRoute) ->
			_.str.startsWith route, noAuthRoute

	checkAdmin = (route) ->
		_.find routesThatRequireAdmin, (adminRoute) ->
			_.str.startsWith route, adminRoute

	$rootScope.$on "$routeChangeStart", (event, next, current) ->

		$location.path "/" if not checkAuth($location.url()) and not Global.user
		if checkAdmin($location.url()) and Global.user.role != "admin"
			$location.path "/notadmin"
		$location.path "/dashboard" if $location.url() is "/" and Global.user