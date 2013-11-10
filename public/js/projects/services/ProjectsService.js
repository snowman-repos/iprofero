(function() {
  angular.module("iprofero.projects").factory("Projects", [
    "$resource", function($resource) {
      return $resource("projects/:projectId", {
        projectId: "@_id"
      }, {
        update: {
          method: "PUT"
        }
      });
    }
  ]);

}).call(this);
