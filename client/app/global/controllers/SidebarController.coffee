# Sidebar controller - this just sets up the menu options

angular.module("iprofero.system").controller "SidebarController", [
	"$scope",
	"Global",
	($scope, Global) ->
		$scope.global = Global
		$scope.menu = [
			title: "People"
			link: "people"
			icon: "users"
		,
			title: "Projects"
			link: "projects"
			icon: "briefcase"
			submenu: [
				title: "All Projects"
				link: "projects"
				icon: "briefcase"
			,
				title: "New Project"
				link: "projects/new"
				icon: "plus"
			]
		,
			title: "Timesheets"
			link: "timesheets"
			icon: "time"
		]
		$scope.admin_menu = [
			title: "Settings"
			link: "admin/settings"
			icon: "settings"
		,
			title: "Reports"
			link: "admin/reports"
			icon: "dashboard"
		]
]