# Header controller

angular.module("iprofero.system").controller "HeaderController", [
	"$scope",
	"Global",
	($scope, Global) ->
		$scope.global = Global
]