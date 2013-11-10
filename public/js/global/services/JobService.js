(function() {
  angular.module("iprofero.system").factory("Jobs", [
    "$resource", function($resource) {
      return $resource("jobs/:jobId", {
        jobId: "@_id"
      });
    }
  ]);

}).call(this);
