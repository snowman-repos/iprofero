(function() {
  angular.module("iprofero.system").factory("Technologies", [
    "$resource", function($resource) {
      return $resource("technologies/:technologyId", {
        technologyId: "@_id"
      });
    }
  ]);

}).call(this);
