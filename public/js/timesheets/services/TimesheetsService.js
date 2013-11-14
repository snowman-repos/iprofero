(function() {
  angular.module("iprofero.timesheets").factory("Timesheets", [
    "$resource", function($resource) {
      return $resource("timesheets/:timesheetId", {
        timesheetId: "@_id"
      }, {
        update: {
          method: "PUT"
        }
      });
    }
  ]);

  angular.module("iprofero.timesheets").factory("PersonTimesheets", [
    "$resource", function($resource) {
      return $resource("users/timesheets/:userId", {
        userId: "@_id"
      });
    }
  ]);

  angular.module("iprofero.timesheets").factory("ProjectTimesheets", [
    "$resource", function($resource) {
      return $resource("projects/timesheets/:projectId", {
        projectId: "@_id"
      });
    }
  ]);

}).call(this);
