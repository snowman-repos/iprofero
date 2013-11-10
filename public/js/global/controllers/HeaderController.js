(function() {
  angular.module("iprofero.system").controller("HeaderController", [
    "$scope", "Global", function($scope, Global) {
      return $scope.global = Global;
    }
  ]);

}).call(this);
