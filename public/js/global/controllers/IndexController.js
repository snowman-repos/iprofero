(function() {
  var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  angular.module("iprofero.system").controller("IndexController", [
    "$scope", "Global", "Jobs", "Skills", "Users", "Projects", "Teams", "$filter", "$location", function($scope, Global, Jobs, Skills, Users, Projects, Teams, $filter, $location) {
      var field, key, required_fields, v, value, _i, _j, _len, _len1;
      $scope.global = Global;
      $scope.user = $scope.global.user;
      required_fields = [
        "email", {
          "contact": ["telephone"]
        }, "job_title"
      ];
      $scope.$watch('date', function() {
        return $scope.user.employment_period.start = $scope.date;
      });
      if ($scope.user != null) {
        for (_i = 0, _len = required_fields.length; _i < _len; _i++) {
          field = required_fields[_i];
          if (typeof field === "object") {
            for (key in field) {
              value = field[key];
              for (_j = 0, _len1 = value.length; _j < _len1; _j++) {
                v = value[_j];
                if ($scope.user[key][v] === "" || ($scope.user[key][v] == null)) {
                  console.log("missing field: " + v);
                  if ($location.path() !== "/welcome") {
                    $location.path("welcome");
                  }
                }
              }
            }
          } else {
            if ($scope.user[field] === "" || ($scope.user[field] == null)) {
              console.log("missing field: " + field);
              if ($location.path() !== "/welcome") {
                $location.path("welcome");
              }
            }
          }
        }
      }
      $scope.welcome = function() {
        $scope.skills = [];
        $scope.skillSuggestions = [];
        Skills.query("", function(skills) {
          var skill, _k, _len2, _results;
          _results = [];
          for (_k = 0, _len2 = skills.length; _k < _len2; _k++) {
            skill = skills[_k];
            _results.push($scope.skillSuggestions.push(skill.name));
          }
          return _results;
        });
        Jobs.query("", function(jobs) {
          return $scope.jobs = jobs;
        });
        Teams.query("", function(teams) {
          return $scope.teams = teams;
        });
        return $scope.getUser(function() {
          if ($scope.user.provider !== "local") {
            $scope.populateDataFromSNS();
          }
          $scope.projects = [];
          $scope.projectsValues = {};
          Projects.query("", function(projects) {
            var participatingInProject, project, _k, _len2, _ref, _ref1, _results;
            $scope.projects = projects;
            _ref = $scope.projects;
            _results = [];
            for (_k = 0, _len2 = _ref.length; _k < _len2; _k++) {
              project = _ref[_k];
              participatingInProject = (_ref1 = $scope.user._id, __indexOf.call(project.participants, _ref1) >= 0);
              _results.push($scope.projectsValues[project._id] = participatingInProject);
            }
            return _results;
          });
          if ($scope.user.avatar === "") {
            $scope.user.avatar = "http://gravatar.com/avatar/" + md5($scope.user.email);
          }
          $scope.skills = $scope.user.skills;
          $scope.step = 1;
          if ($scope.user.projects.length === 0) {
            $scope.step = 4;
          }
          if ($scope.user.skills.length === 0) {
            $scope.step = 3;
          }
          if (($scope.user.salary == null) || ($scope.user.employment_period.start == null)) {
            $scope.step = 2;
          }
          return $scope.$watch('user.employment_period.start', function() {
            return $scope.user.employment_period.start = moment($scope.user.employment_period.start).format("MMMM, YYYY");
          });
        });
      };
      $scope.setParticipation = function() {
        var in_project_participants_list, project, projectUpdated, _k, _len2, _ref, _ref1, _results;
        _ref = $scope.projects;
        _results = [];
        for (_k = 0, _len2 = _ref.length; _k < _len2; _k++) {
          project = _ref[_k];
          projectUpdated = false;
          in_project_participants_list = (_ref1 = $scope.user._id, __indexOf.call(project.participants, _ref1) >= 0);
          if ($scope.projectsValues[project._id]) {
            $scope.user.projects.push({
              id: project._id,
              name: project.name,
              client: project.client
            });
            if (!in_project_participants_list) {
              project.participants.push($scope.user._id);
              projectUpdated = true;
            }
          } else {
            $scope.user.projects = $scope.user.projects.filter(function(proj) {
              return proj.id !== project._id;
            });
            if (in_project_participants_list) {
              project.participants = project.participants.filter(function(person) {
                return person !== $scope.user._id;
              });
              projectUpdated = true;
            }
          }
          if (projectUpdated) {
            _results.push(project.$update(function() {}));
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      };
      $scope.next = function() {
        var newSkill, skill, _k, _len2, _ref, _results;
        $scope.setParticipation();
        $scope.updateUser();
        if ($scope.step === 4) {
          $location.path("me");
        }
        $scope.$apply(function() {
          return $scope.step++;
        });
        if ($scope.step === 4) {
          _ref = $scope.newSkills;
          _results = [];
          for (_k = 0, _len2 = _ref.length; _k < _len2; _k++) {
            newSkill = _ref[_k];
            skill = new Skills({
              name: newSkill
            });
            _results.push(skill.$save(function(response) {}));
          }
          return _results;
        }
      };
      $scope.updateUser = function() {
        var user;
        user = $scope.user;
        if (!user.updated) {
          user.updated = [];
        }
        user.updated.push(new Date().getTime());
        return user.$update(function() {});
      };
      $scope.getUser = function(callback) {
        return Users.get({
          userId: $scope.user._id
        }, function(user) {
          $scope.user = user;
          return callback();
        });
      };
      $scope.populateDataFromSNS = function() {};
      return $scope.tagsUpdated = function(field) {
        $scope.user.skills = $scope.skills;
        return $scope.newSkills = $.grep($scope.user.skills, function(el) {
          return $.inArray(el, $scope.skillSuggestions) === -1;
        });
      };
    }
  ]);

}).call(this);
