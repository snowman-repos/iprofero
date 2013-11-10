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

}).call(this);
