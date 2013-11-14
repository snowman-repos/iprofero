(function() {
  var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  angular.module("iprofero.projects").controller("ProjectsController", [
    "$scope", "$routeParams", "$location", "Global", "Projects", "Users", "Technologies", function($scope, $routeParams, $location, Global, Projects, Users, Technologies) {
      $scope.global = Global;
      $scope.isAdmin = $scope.global.user.role === "admin";
      $scope.$watch('project', function() {
        if ($scope.project != null) {
          $scope.people = [];
          $scope.peopleValues = {};
          $scope.participants = [];
          return Users.query("", function(users) {
            var person, personIsParticipating, _i, _len, _ref, _ref1, _results;
            $scope.people = users;
            _ref = $scope.people;
            _results = [];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              person = _ref[_i];
              personIsParticipating = (_ref1 = person._id, __indexOf.call($scope.project.participants, _ref1) >= 0);
              $scope.peopleValues[person._id] = personIsParticipating;
              if (personIsParticipating) {
                $scope.participants.push(person);
              }
              if (person._id === $scope.project.account_manager.id) {
                $scope.account_manager = person;
              }
              if (person._id === $scope.project.project_manager.id) {
                _results.push($scope.project_manager = person);
              } else {
                _results.push(void 0);
              }
            }
            return _results;
          });
        }
      });
      $scope.newTechnologies = [];
      $scope.technologySuggestions = [];
      Technologies.query("", function(technologies) {
        var technology, _i, _len, _results;
        _results = [];
        for (_i = 0, _len = technologies.length; _i < _len; _i++) {
          technology = technologies[_i];
          _results.push($scope.technologySuggestions.push(technology.name));
        }
        return _results;
      });
      $scope.tagsUpdated = function(field) {
        if (field === "technologies" && ($scope.project != null)) {
          $scope.project.technologies = $scope[field];
          return $scope.newTechnologies = $.grep($scope.project.technologies, function(el) {
            return $.inArray(el, $scope.technologySuggestions) === -1;
          });
        }
      };
      $scope.okToToggle = function(id) {
        return $scope.project.account_manager !== id && $scope.project.project_manager !== id;
      };
      $scope.$watch('hasparent', function() {
        if ($scope.hasparent !== true && ($scope.project != null)) {
          $scope.project.parent.id = "";
          return $scope.project.parent.name = "";
        }
      });
      $scope.setParentage = function() {
        if ($scope.project.parent.id !== "") {
          return Projects.get({
            projectId: $scope.project.parent.id
          }, function(parent) {
            var _ref;
            if (_ref = $scope.project._id, __indexOf.call(parent.sub_projects, _ref) < 0) {
              parent.sub_projects.push({
                id: $scope.project._id,
                name: $scope.project.name
              });
              return parent.$update(function() {});
            }
          });
        } else {
          return Projects.query("", function(potential_parent_projects) {
            var issubproject, project, subproject, _i, _j, _len, _len1, _ref, _results;
            _results = [];
            for (_i = 0, _len = potential_parent_projects.length; _i < _len; _i++) {
              project = potential_parent_projects[_i];
              issubproject = false;
              _ref = project.sub_projects;
              for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
                subproject = _ref[_j];
                if (subproject.id === $scope.project._id) {
                  issubproject = true;
                  break;
                }
              }
              if (issubproject) {
                project.sub_projects = project.sub_projects.filter(function(subproject) {
                  return subproject.id === !$scope.project._id;
                });
                _results.push(project.$update(function() {}));
              } else {
                _results.push(void 0);
              }
            }
            return _results;
          });
        }
      };
      $scope.setParticipants = function() {
        var in_persons_list, person, person_updated, _i, _len, _ref, _ref1;
        $scope.project.participants = [];
        _ref = $scope.people;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          person = _ref[_i];
          in_persons_list = (_ref1 = $scope.project._id, __indexOf.call(person.projects, _ref1) >= 0);
          person_updated = false;
          if ($scope.peopleValues[person._id]) {
            $scope.project.participants.push(person._id);
            if (!in_persons_list) {
              person.projects.push({
                id: $scope.project._id,
                name: $scope.project.name,
                client: $scope.project.client
              });
              person_updated = true;
            }
          } else {
            if (in_persons_list) {
              person.projects = person.projects.filter(function(project) {
                return project === !$scope.project._id;
              });
              person_updated = true;
            }
          }
          if (person_updated) {
            person.$update(function(response) {});
          }
        }
        if ($scope.project.participants.length !== 0) {
          return $scope.project.$update(function() {});
        }
      };
      $scope.create = function() {
        this.name = "";
        this.agency = "";
        this.client = "";
        this.description = "";
        this.parent = {
          id: "",
          name: ""
        };
        this.account_manager = {
          id: "",
          name: ""
        };
        this.project_manager = {
          id: "",
          name: ""
        };
        this.sub_projects = [];
        this.feedback = {};
        this.participants = [];
        this.technologies = [];
        this.github = "";
        this.urls = {
          development: "",
          testing: "",
          staging: "",
          production: ""
        };
        this.quote = "";
        this.purchase_order = "";
        this.invoice = "";
        this.revenue = {
          currency: "yuan",
          amount: 0
        };
        this.cost = 0;
        this.profit = 0;
        $scope.project = new Projects({
          name: this.name,
          agency: $scope.global.user.agency,
          client: this.client,
          description: this.description,
          parent: this.parent,
          account_manager: this.account_manager,
          project_manager: this.project_manager,
          sub_projects: this.sub_projects,
          feedback: this.feedback,
          participants: this.participants,
          technologies: this.technologies,
          github: this.github,
          urls: this.urls,
          quote: this.quote,
          purchase_order: this.purchase_order,
          invoice: this.invoice,
          revenue: this.revenue,
          cost: this.cost,
          profit: this.profit
        });
        return $scope.find();
      };
      $scope.save = function() {
        $scope.saveNewTechnologies();
        return $scope.project.$save(function(response) {
          if (response.errors == null) {
            $scope.project = response;
            $scope.setParticipants();
            $scope.setParentage();
            return $location.path("projects/" + response._id);
          } else {
            return console.log(response.errors.name.message);
          }
        });
      };
      $scope.remove = function() {
        var participant, project, _i, _len, _ref;
        project = $scope.project;
        _ref = $scope.participants;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          participant = _ref[_i];
          participant.projects = participant.projects.filter(function(proj) {
            return proj.id !== project._id;
          });
          participant.$update(function(response) {});
        }
        Projects.query("", function(projects) {
          var proj, _j, _len1, _results;
          _results = [];
          for (_j = 0, _len1 = projects.length; _j < _len1; _j++) {
            proj = projects[_j];
            if (proj.parent.id === project._id) {
              proj.parent.id = "";
              proj.parent.name = "";
              _results.push(proj.$update(function(response) {}));
            } else {
              _results.push(void 0);
            }
          }
          return _results;
        });
        if ((project.parent.id != null) && project.parent.id !== "") {
          return Projects.get({
            projectId: project.parent.id
          }, function(parent) {
            parent.sub_projects = parent.sub_projects.filter(function(proj) {
              return proj.id !== project._id;
            });
            return parent.$update(function(response) {
              return project.$remove(function(response) {
                if (response.$resolved) {
                  if ($scope.projects != null) {
                    $scope.projects = $scope.projects.filter(function(proj) {
                      return proj._id !== project._id;
                    });
                  }
                  return $location.path("projects/");
                }
              });
            });
          });
        } else {
          return project.$remove(function(response) {
            if (response.$resolved) {
              if ($scope.projects != null) {
                $scope.projects = $scope.projects.filter(function(proj) {
                  return proj._id !== project._id;
                });
              }
              return $location.path("projects/");
            }
          });
        }
      };
      $scope.update = function() {
        var project;
        $scope.setParticipants();
        $scope.setParentage();
        project = $scope.project;
        if (!project.updated) {
          project.updated = [];
        }
        project.updated.push(new Date().getTime());
        project.$update(function() {
          return $location.path("projects/" + project._id);
        });
        return $scope.saveNewTechnologies();
      };
      $scope.saveNewTechnologies = function() {
        var newTechnology, technology, _i, _len, _ref, _results;
        _ref = $scope.newTechnologies;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          newTechnology = _ref[_i];
          technology = new Technologies({
            name: newTechnology
          });
          _results.push(technology.$save(function(response) {}));
        }
        return _results;
      };
      $scope.updateSingleProperty = function(property, value) {
        var project;
        project = $scope.project;
        $scope.project[property] = value;
        project[property] = value;
        if (!project.updated) {
          project.updated = [];
        }
        project.updated.push(new Date().getTime());
        return project.$update(function(response) {});
      };
      $scope.find = function(query) {
        return Projects.query(query, function(projects) {
          $scope.projects = projects;
          $scope.predicate = "name";
          return $scope.reverse = false;
        });
      };
      $scope.findOne = function() {
        return Projects.get({
          projectId: $routeParams.projectId
        }, function(project) {
          $scope.project = project;
          if ($scope.project.parent.id !== "") {
            return $scope.hasparent = true;
          }
        });
      };
      $scope.edit = function() {
        $scope.find();
        return $scope.findOne();
      };
      return $scope.view = function() {
        return $scope.findOne();
      };
    }
  ]);

}).call(this);
