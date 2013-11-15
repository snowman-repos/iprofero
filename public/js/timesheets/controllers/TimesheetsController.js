(function() {
  angular.module("iprofero.timesheets").controller("TimesheetsController", [
    "$scope", "Global", "Timesheets", "PersonTimesheets", "ProjectTimesheets", "Users", "Projects", "Activities", "Stopwatch", "TimesheetPreferences", function($scope, Global, Timesheets, PersonTimesheets, ProjectTimesheets, Users, Projects, Activities, Stopwatch, TimesheetPreferences) {
      var $MINIMUM_TIME, project, _i, _len, _ref;
      $scope.user = Global.user;
      $scope.Stopwatch = Stopwatch;
      $MINIMUM_TIME = 900;
      $scope.prefs = {
        logType: "form"
      };
      $scope.resetNewTimeLog = function() {
        return $scope.newtimelog = {
          time: 0,
          project: TimesheetPreferences.get("project"),
          activity: TimesheetPreferences.get("activity"),
          date: new Date(moment()),
          startdate: new Date(moment()),
          enddate: new Date(moment()),
          hours: TimesheetPreferences.get("hours"),
          comment: ""
        };
      };
      $scope.resetNewTimeLog();
      $scope.projectNames = [];
      _ref = $scope.user.projects;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        project = _ref[_i];
        $scope.projectNames[project.id] = project.name;
        if (project.id === $scope.newtimelog.project) {
          $scope.project = project;
        }
      }
      if ($scope.project === null || $scope.project === "") {
        $scope.project = $scope.user.projects[0];
        $scope.newtimelog.project = $scope.user.projects[0].id;
        $scope.setProject();
      }
      $scope.activityNames = [];
      Activities.query("", function(activities) {
        var activity, _j, _len1, _results;
        $scope.activities = activities;
        _results = [];
        for (_j = 0, _len1 = activities.length; _j < _len1; _j++) {
          activity = activities[_j];
          $scope.activityNames[activity._id] = activity.name;
          if (activity._id === $scope.newtimelog.activity) {
            _results.push($scope.activity = activity);
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      });
      if ($scope.activity === null || $scope.activity === "") {
        $scope.activity = $scope.activities[0];
        $scope.newtimelog.project = $scope.activities[0].id;
        $scope.setActivity();
      }
      $scope.myTimelogs = [];
      PersonTimesheets.query({
        userId: $scope.user._id
      }, function(timelogs) {
        return $scope.myTimelogs = timelogs;
      });
      $scope.hoursThisWeek = 12;
      $scope.activeProjects = 3;
      $scope.prefs.logType = TimesheetPreferences.get("logType");
      if ($scope.prefs.logType === "") {
        $scope.prefs.logType = "form";
        $scope.setLogType();
      }
      if ((TimesheetPreferences.get("dateRange")).toLocaleLowerCase().trim() === "true") {
        $scope.prefs.dateRange = true;
      } else {
        $scope.prefs.dateRange = false;
      }
      if ($scope.prefs.dateRange == null) {
        $scope.prefs.dateRange = false;
      }
      $scope.$watch("newtimelog.hours", function() {
        $scope.valid = $scope.newtimelog.hours > 0.25 && $scope.newtimelog.hours < 24;
        if ($scope.valid) {
          $scope.newtimelog.time = $scope.newtimelog.hours * 60 * 60;
          return $scope.setHours();
        }
      });
      $scope.$watch("newtimelog.time", function() {
        return $scope.newtimelog.hours = $scope.newtimelog.time / 60 / 60;
      });
      $scope.$watch("project", function() {
        if ($scope.project != null) {
          $scope.newtimelog.project = $scope.project.id;
          return $scope.setProject();
        }
      });
      $scope.$watch("activity", function() {
        if ($scope.activity) {
          $scope.newtimelog.activity = $scope.activity._id;
          return $scope.setActivity();
        }
      });
      $scope.$watch("newtimelog.date", function() {
        if (moment($scope.newtimelog.date).format("DD/MM/YYYY") === moment().format("DD/MM/YYYY")) {
          return $scope.date = "today";
        } else if (moment($scope.newtimelog.date).format("DD/MM/YYYY") === moment().subtract('days', 1).format("DD/MM/YYYY")) {
          return $scope.date = "yesterday";
        } else if (moment($scope.newtimelog.date).isSame(moment(), 'week')) {
          return $scope.date = moment($scope.newtimelog.date).format("dddd");
        } else {
          return $scope.date = moment($scope.newtimelog.date).format("DD MMM");
        }
      });
      $scope.$watch("newtimelog.startdate", function() {
        if (moment($scope.newtimelog.startdate).format("DD/MM/YYYY") === moment().format("DD/MM/YYYY")) {
          return $scope.startdate = "today";
        } else if (moment($scope.newtimelog.startdate).format("DD/MM/YYYY") === moment().subtract('days', 1).format("DD/MM/YYYY")) {
          return $scope.startdate = "yesterday";
        } else if (moment($scope.newtimelog.startdate).isSame(moment(), 'week')) {
          return $scope.startdate = moment($scope.newtimelog.startdate).format("dddd");
        } else {
          return $scope.startdate = moment($scope.newtimelog.startdate).format("DD MMM");
        }
      });
      $scope.$watch("newtimelog.enddate", function() {
        if (moment($scope.newtimelog.enddate).format("DD/MM/YYYY") === moment().format("DD/MM/YYYY")) {
          return $scope.enddate = "today";
        } else if (moment($scope.newtimelog.enddate).format("DD/MM/YYYY") === moment().subtract('days', 1).format("DD/MM/YYYY")) {
          return $scope.enddate = "yesterday";
        } else if (moment($scope.newtimelog.enddate).isSame(moment(), 'week')) {
          return $scope.enddate = moment($scope.newtimelog.enddate).format("dddd");
        } else {
          return $scope.enddate = moment($scope.newtimelog.enddate).format("DD MMM");
        }
      });
      $scope.validate = function() {
        return $scope.$apply($scope.valid = true);
      };
      $scope.invalidate = function() {
        return $scope.$apply($scope.valid = false);
      };
      $scope.setLogType = function() {
        return TimesheetPreferences.set("logType", $scope.prefs.logType);
      };
      $scope.setProject = function() {
        return TimesheetPreferences.set("project", $scope.newtimelog.project);
      };
      $scope.setActivity = function() {
        return TimesheetPreferences.set("activity", $scope.newtimelog.activity);
      };
      $scope.setHours = function() {
        return TimesheetPreferences.set("hours", $scope.newtimelog.hours);
      };
      $scope.setDateFormat = function() {
        return TimesheetPreferences.set("dateRange", $scope.prefs.dateRange);
      };
      $scope.logTime = function() {
        var end, start;
        if ($scope.prefs.logType === "timer") {
          if (Stopwatch.data.value > $MINIMUM_TIME && $scope.newtimelog.project !== "" && $scope.newtimelog.activity !== "" && $scope.newtimelog.date !== "") {
            $scope.newtimelog.time = Stopwatch.data.value;
            $scope.newtimelog.hours = Stopwatch.data.value / 60 / 60;
            $scope.save($scope.newtimelog);
            $scope.resetNewTimeLog();
            $scope.newtimelog.hours = 0;
            return Stopwatch.reset();
          } else {
            console.log("can't save - incomplete data or time too short");
            console.log("Time: " + Stopwatch.data.value + "s");
            return console.log($scope.newtimelog);
          }
        } else {
          if ($scope.newtimelog.project === "" || $scope.newtimelog.activity === "" || $scope.newtimelog.date === "" || $scope.newtimelog.time === 0 || !$scope.valid) {
            console.log("can't save - incomplete data");
            return console.log($scope.newtimelog);
          } else {
            if ($scope.prefs.dateRange === false) {
              $scope.save($scope.newtimelog);
              $scope.resetNewTimeLog();
              return $scope.newtimelog.hours = 0;
            } else {
              start = moment($scope.newtimelog.startdate);
              end = moment($scope.newtimelog.enddate);
              while (start.isBefore(end)) {
                $scope.newtimelog.date = new Date(start);
                $scope.save($scope.newtimelog);
                start.add("days", 1);
              }
              $scope.resetNewTimeLog();
              return $scope.newtimelog.hours = 0;
            }
          }
        }
      };
      $scope.newTimesheet = function(timesheet) {
        var newtimesheet;
        return newtimesheet = new Timesheets({
          activity: timesheet.activity,
          agency: $scope.user.agency,
          date: timesheet.date,
          hours: timesheet.hours,
          person: $scope.user._id,
          project: timesheet.project,
          comment: timesheet.comment
        });
      };
      $scope.save = function(timesheet) {
        var newtimesheet;
        newtimesheet = $scope.newTimesheet(timesheet);
        return newtimesheet.$save(function(response) {
          return $scope.myTimelogs.push(response);
        });
      };
      $scope.update = function(id) {
        var timesheet;
        timesheet = $scope.myTimelogs.filter(function(timelog) {
          return timelog._id === id;
        });
        if (timesheet.length !== 0) {
          return timesheet[0].$update(function(response) {});
        }
      };
      return $scope["delete"] = function(id) {
        var timesheet;
        timesheet = $scope.myTimelogs.filter(function(timelog) {
          return timelog._id === id;
        });
        if (timesheet.length !== 0) {
          return timesheet[0].$remove(function(response) {
            if ($scope.myTimelogs != null) {
              return $scope.myTimelogs = $scope.myTimelogs.filter(function(timelog) {
                return timelog._id !== response._id;
              });
            }
          });
        }
      };
    }
  ]);

}).call(this);
