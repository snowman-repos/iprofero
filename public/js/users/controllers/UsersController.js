(function() {
  angular.module("iprofero.users").controller("UsersController", [
    "$scope", "$routeParams", "$location", "Global", "Users", "Projects", "Skills", "$http", function($scope, $routeParams, $location, Global, Users, Projects, Skills, $http) {
      $scope.global = Global;
      $scope.loggedInUser = $scope.global.user;
      $scope.isAdmin = $scope.global.user.role === "admin";
      $scope.skills = [];
      $scope.skillSuggestions = [];
      Skills.query("", function(skills) {
        var skill, _i, _len, _results;
        _results = [];
        for (_i = 0, _len = skills.length; _i < _len; _i++) {
          skill = skills[_i];
          _results.push($scope.skillSuggestions.push(skill.name));
        }
        return _results;
      });
      $scope.tagsUpdated = function(field) {
        if ($scope.user) {
          $scope.user.skills = $scope.skills;
          $scope.updateSingleProperty('skills', $scope.skills);
          return $scope.newSkills = $.grep($scope.user.skills, function(el) {
            return $.inArray(el, $scope.skillSuggestions) === -1;
          });
        }
      };
      $scope.remove = function() {
        var project, user, _i, _len, _ref;
        if ($scope.user._id !== $scope.loggedInUser._id) {
          user = $scope.user;
          _ref = $scope.projects;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            project = _ref[_i];
            project.participants = project.participants.filter(function(participant) {
              return participant !== user._id;
            });
            project.$update(function(response) {});
          }
          return user.$remove(function(response) {
            if (response.$resolved) {
              return $location.path("people/");
            }
          });
        }
      };
      $scope.update = function() {
        var user;
        user = $scope.user;
        if (!user.updated) {
          user.updated = [];
        }
        user.updated.push(new Date().getTime());
        return user.$update(function() {
          return $location.path("users/" + user._id);
        });
      };
      $scope.updateSingleProperty = function(property, value) {
        var user;
        user = $scope.user;
        user[property] = value;
        if (!user.updated) {
          user.updated = [];
        }
        user.updated.push(new Date().getTime());
        return user.$update(function() {});
      };
      $scope.find = function(query) {
        return Users.query(query, function(users) {
          $scope.users = users;
          $scope.predicate = "name";
          return $scope.reverse = false;
        });
      };
      $scope.findOne = function() {
        return Users.get({
          userId: $routeParams.userId
        }, function(user) {
          return $scope.setUser(user);
        });
      };
      $scope.findMe = function() {
        return Users.get({
          userId: $scope.loggedInUser._id
        }, function(user) {
          return $scope.setUser(user);
        });
      };
      return $scope.setUser = function(user) {
        var enddate, startdate;
        $scope.user = user;
        $scope.skills = $scope.user.skills;
        startdate = $scope.user.employment_period.start;
        enddate = $scope.user.employment_period.end;
        $scope.user.employment_period.start = moment(startdate).format("MMMM, YYYY");
        $scope.user.employment_period.end = moment(enddate).format("MMMM, YYYY");
        return $scope.isLoggedInUser = $scope.loggedInUser._id === user._id;
      };
    }
  ]);

}).call(this);
