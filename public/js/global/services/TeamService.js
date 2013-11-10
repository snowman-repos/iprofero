(function() {
  angular.module("iprofero.system").factory("Teams", [
    "$resource", function($resource) {
      return $resource("teams/:teamId", {
        teamId: "@_id"
      });
    }
  ]);

}).call(this);
