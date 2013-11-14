(function() {
  angular.module("iprofero.system").directive("formatDate", function() {
    return {
      restrict: "A",
      link: function(scope, element, attrs) {
        return element.on("blur", function() {
          return element.val(moment(element.val()).format("MMMM, YYYY"));
        });
      }
    };
  });

  angular.module("iprofero.system").directive("onEnter", function() {
    return {
      restrict: "A",
      link: function(scope, element, attrs) {
        return element.on("keydown", function(event) {
          if (event.which === 13) {
            return scope.$apply(attrs.onEnter);
          }
        });
      }
    };
  });

  angular.module("iprofero.system").directive("onEscape", function() {
    return {
      restrict: "A",
      link: function(scope, element, attrs) {
        return element.on("keydown", function(event) {
          if (event.which === 27) {
            return scope.$apply(attrs.onEscape);
          }
        });
      }
    };
  });

  angular.module("iprofero.system").directive("validNumber", function() {
    return {
      require: "?ngModel",
      link: function(scope, element, attrs, ngModelCtrl) {
        if (!ngModelCtrl) {
          return;
        }
        ngModelCtrl.$parsers.push(function(val) {
          var clean;
          clean = val.replace(/[^0-9,.]+/g, "");
          if (val !== clean) {
            ngModelCtrl.$setViewValue(clean);
            ngModelCtrl.$render();
          }
          return clean;
        });
        return element.bind("keypress", function(event) {
          if (event.keyCode === 32) {
            return event.preventDefault();
          }
        });
      }
    };
  });

  angular.module("iprofero.system").directive("validateWelcome", function() {
    ({
      restrict: "A"
    });
    return function(scope, element, attrs) {
      var phoneValid, validationRules;
      validationRules = {
        email: {
          identifier: 'email',
          rules: [
            {
              type: 'email',
              prompt: 'Please enter a valid email'
            }
          ]
        },
        telephone: {
          identifier: 'telephone',
          rules: [
            {
              type: 'empty',
              prompt: 'Please enter a telephone number'
            }, {
              type: 'length[10]',
              prompt: 'Telephone number must be at least 10 digits'
            }
          ]
        },
        salary: {
          identifier: 'salary',
          rules: [
            {
              type: 'empty',
              prompt: 'Please enter your salary'
            }
          ]
        },
        startdate: {
          identifier: 'startdate',
          rules: [
            {
              type: 'empty',
              prompt: 'Please enter your start date'
            }
          ]
        },
        website: {
          identifier: 'website',
          rules: [
            {
              type: 'url',
              prompt: 'Website must be a URL'
            }
          ]
        }
      };
      phoneValid = attrs.validateWelcome !== 1;
      element.form(validationRules, {
        inline: true,
        on: "blur",
        onValid: function() {
          var test;
          if (this.get(0).id === "telephone") {
            test = /^([0-9\(\)\/\+ \-]*)$/.test(this.get(0).value);
            if (test) {
              return phoneValid = true;
            }
          }
        }
      });
      return element.find(".button").on("click", function() {
        var $phone;
        if (element.form('validate form') && phoneValid) {
          return scope.next();
        } else {
          $phone = element.find(".phone.field");
          if (!$phone.hasClass("error")) {
            element.find(".phone.field").addClass("error");
            return element.find(".phone.field").append('<div class="ui\
					 red pointing prompt label transition visible">Please\
					  enter a valid telephone number</div>');
          }
        }
      });
    };
  });

  angular.module("iprofero.system").directive("validate", function() {
    ({
      restrict: "A"
    });
    return function(scope, element, attrs) {
      var validationRules;
      validationRules = {
        name: {
          identifier: 'name',
          rules: [
            {
              type: 'empty',
              prompt: 'Please enter your name'
            }
          ]
        },
        email: {
          identifier: 'email',
          rules: [
            {
              type: 'email',
              prompt: 'Please enter a valid email'
            }
          ]
        },
        username: {
          identifier: 'username',
          rules: [
            {
              type: 'empty',
              prompt: 'Please enter a username'
            }
          ]
        },
        password: {
          identifier: 'password',
          rules: [
            {
              type: 'empty',
              prompt: 'Please enter a password'
            }, {
              type: 'length[6]',
              prompt: 'Your password must be at least 6 characters'
            }
          ]
        },
        terms: {
          identifier: 'terms',
          rules: [
            {
              type: 'checked',
              prompt: 'You must agree to the terms and conditions'
            }
          ]
        }
      };
      element.form(validationRules, {
        inline: true,
        on: "blur"
      });
      return element.on("submit", function() {
        return element.addClass("loading");
      });
    };
  });

  angular.module("iprofero.system").directive("checkbox", function() {
    return {
      restrict: "A",
      link: function(scope, element, attrs) {
        return element.checkbox();
      }
    };
  });

  angular.module("iprofero.system").directive("dimmer", function() {
    return function(scope, element, attrs) {
      return element.on("click", function(event) {
        return $('.dimmer').dimmer('show');
      });
    };
  });

  angular.module("iprofero.system").directive("dismissable", function() {
    return function(scope, element, attrs) {
      return element.find(".close.icon").bind("click", function() {
        return element.hide();
      });
    };
  });

  angular.module("iprofero.system").directive("sidebar", function() {
    return function(scope, element, attrs) {
      return element.sidebar({
        debug: false,
        performance: false,
        verbose: false
      });
    };
  });

  angular.module("iprofero.system").directive("dropdown", function() {
    return function(scope, element, attrs) {
      element.dropdown();
      return element.find(".menu").on("click", function() {
        return element.dropdown("hide");
      });
    };
  });

  angular.module("iprofero.system").directive("toggleSidebar", function() {
    return function(scope, element, attrs) {
      var menu;
      menu = angular.element(document.querySelector('.sidebar'));
      return element.bind("click", function() {
        return menu.sidebar('toggle');
      });
    };
  });

  angular.module("iprofero.system").directive("closeSidebar", function() {
    return function(scope, element, attrs) {
      var menu;
      menu = angular.element(document.querySelector('.sidebar'));
      return element.bind("click", function() {
        if (menu.sidebar('is open')) {
          return menu.sidebar('hide');
        }
      });
    };
  });

  angular.module("iprofero.system").directive("multipleProjectSelect", function() {
    var listTemplate;
    listTemplate = "		<div class='ui divided multi selection list'>			<div class='item' data-ng-repeat='object in objects'			 data-ng-click='toggleSelect(object)'			 data-ng-class='{\"active\":values[object._id]}'>				<input type='checkbox' data-ng-model='values[object._id]'				 value='object._id'>				<i class='large right floated check icon'				 data-ng-show='values[object._id]'></i>				<div class='content'>					<div class='header' data-ng-bind='object.name'></div>					<span data-ng-bind='object.client || \"client\"'></span>				</div>			</div>		</div>	";
    return {
      restrict: "E",
      replace: true,
      template: listTemplate,
      scope: {
        values: "=values",
        objects: "=objects"
      },
      link: function(scope, element, attrs) {},
      controller: function($scope) {
        return $scope.toggleSelect = function(object) {
          return $scope.values[object._id] = !$scope.values[object._id];
        };
      }
    };
  });

  angular.module("iprofero.system").directive("multiplePeopleSelect", function() {
    var listTemplate;
    listTemplate = "		<div class='ui divided multi selection list'>			<div class='item' data-ng-repeat='object in objects'			 data-ng-click='toggleSelect(object)'			 data-ng-class='{\"active\":values[object._id]}'>				<input type='checkbox' data-ng-model='values[object._id]'				 value='object._id'>				<i class='large floated left circular user icon'				 data-ng-if='!object.avatar'></i>				<img class='ui avatar image' data-ng-src='{{object.avatar}}'				 data-ng-if='object.avatar'>				<i class='large right floated check icon'				 data-ng-show='values[object._id]'></i>				<div class='content'>					<div class='header' data-ng-bind='object.name'></div>					<span data-ng-bind='object.job_title || \"job title\"'></span>				</div>			</div>		</div>	";
    return {
      restrict: "E",
      replace: true,
      template: listTemplate,
      scope: {
        values: "=values",
        objects: "=objects"
      },
      link: function(scope, element, attrs) {},
      controller: function($scope) {
        return $scope.toggleSelect = function(object) {
          if ($scope.$parent.okToToggle(object._id)) {
            return $scope.values[object._id] = !$scope.values[object._id];
          }
        };
      }
    };
  });

  angular.module("iprofero.system").directive("clickToEdit", function() {
    var editorTemplate;
    editorTemplate = "		<div class='click-to-edit'>			<div data-ng-hide='view.editorEnabled'>				<span>{{ value || default }}</span>				<a class='edit-in-place' data-ng-click='enableEditor()'>					<i class='pencil icon'></i>				</a>			</div>			<div class='ui form' data-ng-show='view.editorEnabled'>				<div class='ui action input'>					<input on-enter='save()' on-escape='disableEditor()'					 data-ng-model='view.editableValue' type='text'>					<a class='ui icon teal button' data-ng-click='save()'>						<i class='check icon'></i>					</a>					<a class='ui icon button' data-ng-click='disableEditor()'>						<i class='remove icon'></i>					</a>				</div>			</div>		</div>";
    return {
      restrict: "A",
      replace: true,
      template: editorTemplate,
      scope: {
        property: "@clickToEdit",
        value: "=clickToEdit",
        "default": "=default",
        resource: "=resource"
      },
      link: function($scope, element, attrs) {
        return $scope.$watch("view.editorEnabled", function() {
          if ($scope.view.editorEnabled === true) {
            return element.find("input").focus();
          }
        });
      },
      controller: function($scope) {
        $scope.view = {
          editableValue: $scope.value,
          editorEnabled: false
        };
        $scope.enableEditor = function() {
          $scope.view.editorEnabled = true;
          return $scope.view.editableValue = $scope.value;
        };
        $scope.disableEditor = function() {
          return $scope.view.editorEnabled = false;
        };
        return $scope.save = function() {
          var actualProperty, p;
          p = $scope.property;
          actualProperty = p.substr(p.indexOf('.') + 1, p.length);
          $scope.value = $scope.view.editableValue;
          if ($scope.resource != null) {
            $scope.resource[actualProperty] = $scope.value;
            $scope.$parent.update($scope.resource);
            return $scope.disableEditor();
          } else {
            $scope.$parent.updateSingleProperty(actualProperty, $scope.value);
            return $scope.disableEditor();
          }
        };
      }
    };
  });

  angular.module("iprofero.system").directive("clickToEditHeadline", function() {
    var editorTemplate;
    editorTemplate = "		<div>			<span data-ng-hide='view.editorEnabled' class='edit-in-place'			 data-ng-click='enableEditor()'>{{ value || default }}</span>			<div class='ui form' data-ng-show='view.editorEnabled'>				<div class='ui action input'>					<input on-enter='save()' on-escape='disableEditor()'					 data-ng-model='view.editableValue' type='text'>					<a class='ui icon teal button' data-ng-click='save()'>						<i class='check icon'></i>					</a>					<a class='ui icon button' data-ng-click='disableEditor()'>						<i class='remove icon'></i>					</a>				</div>			</div>		</div>";
    return {
      restrict: "A",
      replace: true,
      template: editorTemplate,
      scope: {
        property: "@clickToEditHeadline",
        value: "=clickToEditHeadline",
        "default": "=default",
        resource: "=resource"
      },
      link: function($scope, element, attrs) {
        return $scope.$watch("view.editorEnabled", function() {
          if ($scope.view.editorEnabled === true) {
            return element.find("input").focus();
          }
        });
      },
      controller: function($scope) {
        $scope.view = {
          editableValue: $scope.value,
          editorEnabled: false
        };
        $scope.enableEditor = function() {
          $scope.view.editorEnabled = true;
          return $scope.view.editableValue = $scope.value;
        };
        $scope.disableEditor = function() {
          return $scope.view.editorEnabled = false;
        };
        return $scope.save = function() {
          var actualProperty, p;
          p = $scope.property;
          actualProperty = p.substr(p.indexOf('.') + 1, p.length);
          $scope.value = $scope.view.editableValue;
          if ($scope.resource != null) {
            $scope.resource[actualProperty] = $scope.value;
            $scope.$parent.update($scope.resource);
            return $scope.disableEditor();
          } else {
            $scope.$parent.updateSingleProperty(actualProperty, $scope.value);
            return $scope.disableEditor();
          }
        };
      }
    };
  });

  angular.module("iprofero.system").directive("focus", function() {
    return {
      restrict: "A",
      link: function(scope, element, attrs) {
        return element.focus();
      }
    };
  });

}).call(this);
