(function() {
  angular.module("iprofero.system").factory("Activities", [
    "$resource", function($resource) {
      return $resource("activities/:activityId", {
        activityId: "@_id"
      }, {
        update: {
          method: "PUT"
        }
      });
    }
  ]);

}).call(this);
