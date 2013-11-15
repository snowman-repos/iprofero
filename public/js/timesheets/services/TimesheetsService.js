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
      return $resource("users/:userId/timesheets/:timesheetId", {
        timesheetId: "@_id",
        userId: "@person"
      }, {
        update: {
          method: "PUT"
        }
      });
    }
  ]);

  angular.module("iprofero.timesheets").factory("ProjectTimesheets", [
    "$resource", function($resource) {
      return $resource("projects/:projectId/timesheets/:timesheetId", {
        timesheetId: "@_id",
        projectId: "@project"
      }, {
        update: {
          method: "PUT"
        }
      });
    }
  ]);

}).call(this);
