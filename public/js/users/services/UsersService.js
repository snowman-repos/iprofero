(function() {
  angular.module("iprofero.users").factory("Users", [
    "$resource", function($resource) {
      return $resource("users/:userId", {
        userId: "@_id"
      }, {
        update: {
          method: "PUT"
        }
      });
    }
  ]);

}).call(this);
