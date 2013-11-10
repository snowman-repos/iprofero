(function() {
  angular.module("iprofero.admin").controller("AdminController", [
    "$scope", "Global", "$location", "Skills", "Technologies", "Teams", "Jobs", "Activities", function($scope, Global, $location, Skills, Technologies, Teams, Jobs, Activities) {
      if (Global.user.role === !"admin") {
        $location.path("/");
      }
      $scope.settings = function() {
        Skills.query("", function(skills) {
          return $scope.skills = skills;
        });
        Technologies.query("", function(technologies) {
          return $scope.technologies = technologies;
        });
        Teams.query("", function(teams) {
          return $scope.teams = teams;
        });
        Jobs.query("", function(jobs) {
          return $scope.jobs = jobs;
        });
        Activities.query("", function(activities) {
          return $scope.activities = activities;
        });
        return $scope.new_activity = {
          agency: Global.user.agency,
          name: "",
          billable: false,
          rate: 0,
          parent: {
            id: "",
            name: ""
          },
          isparent: false
        };
      };
      $scope.addJob = function(newJob) {
        var job;
        if (newJob !== "") {
          job = new Jobs({
            title: newJob
          });
          return job.$save(function(response) {
            if (response.errors == null) {
              $scope.jobs.push(response);
            } else {
              console.log(response.errors.title.message);
            }
            return $scope.newJob = "";
          });
        }
      };
      $scope.removeJob = function(id) {
        return Jobs.get({
          jobId: id
        }, function(job) {
          job.$remove();
          return $scope.jobs = $scope.jobs.filter(function(j) {
            return j._id !== job._id;
          });
        });
      };
      $scope.addTeam = function(newTeam) {
        var team;
        if (newTeam !== "") {
          team = new Teams({
            name: newTeam
          });
          return team.$save(function(response) {
            if (response.errors == null) {
              $scope.teams.push(response);
            } else {
              console.log(response.errors.name.message);
            }
            return $scope.newTeam = "";
          });
        }
      };
      $scope.removeTeam = function(id) {
        return Teams.get({
          teamId: id
        }, function(team) {
          team.$remove();
          return $scope.teams = $scope.teams.filter(function(t) {
            return t._id !== team._id;
          });
        });
      };
      $scope.addTechnology = function(newTechnology) {
        var technology;
        if (newTechnology !== "") {
          technology = new Technologies({
            name: newTechnology
          });
          return technology.$save(function(response) {
            if (response.errors == null) {
              $scope.technologies.push(response);
            } else {
              console.log(response.errors.name.message);
            }
            return $scope.newTechnology = "";
          });
        }
      };
      $scope.removeTechnology = function(id) {
        return Technologies.get({
          technologyId: id
        }, function(technology) {
          technology.$remove();
          return $scope.technologies = $scope.technologies.filter(function(j) {
            return j._id !== technology._id;
          });
        });
      };
      $scope.addSkill = function(newSkill) {
        var skill;
        if (newSkill !== "") {
          skill = new Skills({
            name: newSkill
          });
          return skill.$save(function(response) {
            if (response.errors == null) {
              $scope.skills.push(response);
            } else {
              console.log(response.errors.name.message);
            }
            return $scope.newSkill = "";
          });
        }
      };
      $scope.removeSkill = function(id) {
        return Skills.get({
          skillId: id
        }, function(skill) {
          skill.$remove();
          return $scope.skills = $scope.skills.filter(function(j) {
            return j._id !== skill._id;
          });
        });
      };
      $scope.addActivity = function() {
        var activity;
        if ($scope.new_activity.name !== "") {
          activity = new Activities({
            agency: $scope.new_activity.agency,
            name: $scope.new_activity.name,
            billable: $scope.new_activity.billable,
            rate: $scope.new_activity.rate,
            isparent: $scope.new_activity.isparent,
            parent: {
              id: $scope.new_activity.parent.id,
              name: $scope.new_activity.parent.name
            }
          });
          return activity.$save(function(response) {
            var _i, _len, _ref;
            if (response.errors == null) {
              $scope.activities.push(response);
              if ((response.parent.id != null) && response.parent.id !== "") {
                _ref = $scope.activities;
                for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                  activity = _ref[_i];
                  if (activity._id === response.parent.id) {
                    activity.isparent = true;
                    $scope.update(activity);
                  }
                }
              }
            } else {
              console.log(response.errors.name.message);
            }
            $scope.new_activity.name = "";
            $scope.new_activity.billable = false;
            $scope.new_activity.rate = 0;
            $scope.new_activity.isparent = false;
            return $scope.new_activity.parent = {
              id: "",
              name: ""
            };
          });
        }
      };
      $scope.update = function(activity) {
        return activity.$update(function(response) {
          if (response.errors != null) {
            return console.log(response.errors);
          }
        });
      };
      $scope.updateParent = function(child, parent) {
        var oldparent;
        if ((child.parent.id != null) && child.parent.id !== "") {
          oldparent = child.parent.id;
        }
        Activities.get({
          activityId: child._id
        }, function(activity) {
          activity.parent.id = parent._id;
          activity.parent.name = parent.name;
          return $scope.update(activity);
        });
        Activities.get({
          activityId: parent._id
        }, function(activity) {
          activity.isparent = true;
          return $scope.update(activity);
        });
        if (oldparent != null) {
          return $scope.setActivityParentage();
        }
      };
      $scope.setActivityParentage = function() {
        var activity, childfound, otheractivity, updated, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2, _results;
        _ref = $scope.activities;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          activity = _ref[_i];
          updated = false;
          if (activity.isparent) {
            childfound = false;
            _ref1 = $scope.activities;
            for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
              otheractivity = _ref1[_j];
              if (otheractivity.parent.id === activity._id) {
                childfound = true;
              }
            }
            if (!childfound) {
              activity.isparent = false;
              updated = true;
            }
          } else {
            _ref2 = $scope.activities;
            for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
              otheractivity = _ref2[_k];
              if (otheractivity.parent.id === activity._id) {
                activity.isparent = true;
                updated = true;
              }
            }
          }
          if (updated) {
            _results.push($scope.update(activity));
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      };
      return $scope.removeActivity = function(id) {
        return Activities.get({
          activityId: id
        }, function(activity) {
          var otheractivity, updated, _i, _len, _ref;
          activity.$remove();
          $scope.activities = $scope.activities.filter(function(j) {
            return j._id !== activity._id;
          });
          _ref = $scope.activities;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            otheractivity = _ref[_i];
            updated = false;
            if (otheractivity.parent.id === id) {
              otheractivity.parent.id = "";
              otheractivity.parent.name = "";
              updated = true;
            }
            if (updated) {
              $scope.update(otheractivity);
            }
          }
          return $scope.setActivityParentage();
        });
      };
    }
  ]);

}).call(this);
