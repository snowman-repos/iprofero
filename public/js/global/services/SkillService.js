(function() {
  angular.module("iprofero.system").factory("Skills", [
    "$resource", function($resource) {
      return $resource("skills/:skillId", {
        skillId: "@_id"
      });
    }
  ]);

}).call(this);
