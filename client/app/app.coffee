# app entry point to define modules and dependencies

window.app = angular.module("iprofero", [
	"ngCookies",
	"ngResource",
	"ngSanitize",
	"ui.route",
	"ui.mask",
	"ui.bootstrap.datetimepicker",
	"xeditable",
	"tags-input",
	"underscore",
	"angulartics",
	"angulartics.google.analytics",
	"ui.bootstrap",
	"iprofero.system",
	"iprofero.users",
	"iprofero.projects",
	"iprofero.timesheets",
	"iprofero.admin"
])
angular.module "iprofero.system", []
angular.module "iprofero.users", []
angular.module "iprofero.projects", []
angular.module "iprofero.timesheets", []
angular.module "iprofero.admin", []