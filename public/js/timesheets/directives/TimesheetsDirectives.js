(function() {
  var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  angular.module("iprofero.timesheets").directive("validateTime", function() {
    ({
      restrict: "A"
    });
    return function(scope, element, attrs) {
      var $field, clearError, showHoursError, testHours;
      $field = element.parent().parent();
      element.on("blur", function() {
        return testHours();
      });
      testHours = function() {
        var $val, test;
        $val = element.val();
        test = /^(?:([0-9.]|[1][0-9]|[2][0-3])([.]([1-9]|[0-9][1-9]))?)$/.test($val);
        if (!test) {
          showHoursError();
          return scope.invalidate();
        } else {
          element.addClass("valid");
          clearError();
          return scope.validate();
        }
      };
      showHoursError = function() {
        if (!$field.hasClass("error")) {
          $field.addClass("error");
          return $field.append('<div class="ui\
				 red pointing prompt label transition visible">Please enter a number\
				 between 0 and 24</div>');
        }
      };
      return clearError = function() {
        $field.removeClass("error");
        return $field.find(".ui.red.label").remove();
      };
    };
  });

  angular.module("iprofero.timesheets").directive("chosen", [
    '$timeout', function($timeout) {
      var CHOSEN_OPTION_WHITELIST, NG_OPTIONS_REGEXP, chosen, isEmpty, snakeCase;
      NG_OPTIONS_REGEXP = /^\s*(.*?)(?:\s+as\s+(.*?))?(?:\s+group\s+by\s+(.*))?\s+for\s+(?:([\$\w][\$\w\d]*)|(?:\(\s*([\$\w][\$\w\d]*)\s*,\s*([\$\w][\$\w\d]*)\s*\)))\s+in\s+(.*)$/;
      CHOSEN_OPTION_WHITELIST = ['noResultsText', 'allowSingleDeselect', 'disableSearchThreshold', 'disableSearch', 'enableSplitWordSearch', 'inheritSelectClasses', 'maxSelectedOptions', 'placeholderTextMultiple', 'placeholderTextSingle', 'searchContains', 'singleBackstrokeDelete', 'displayDisabledOptions', 'displaySelectedOptions', 'width'];
      snakeCase = function(input) {
        return input.replace(/[A-Z]/g, function($1) {
          return "_" + ($1.toLowerCase());
        });
      };
      isEmpty = function(value) {
        var key, _i, _len;
        if (angular.isArray(value)) {
          return value.length === 0;
        } else if (angular.isObject(value)) {
          for (_i = 0, _len = value.length; _i < _len; _i++) {
            key = value[_i];
            if (value.hasOwnProperty(key)) {
              return false;
            }
          }
        }
        return true;
      };
      return chosen = {
        restrict: 'A',
        require: '?ngModel',
        terminal: true,
        link: function(scope, element, attr, ctrl) {
          var disableWithMessage, match, options, origRender, startLoading, stopLoading, valuesExpr, viewWatch;
          options = scope.$eval(attr.chosen) || {};
          angular.forEach(attr, function(value, key) {
            return options[snakeCase(key)] = __indexOf.call(CHOSEN_OPTION_WHITELIST, key) >= 0 ? scope.$eval(value) : void 0;
          });
          startLoading = function() {
            return element.addClass('loading').attr('disabled', true).trigger('chosen:updated');
          };
          stopLoading = function() {
            return element.removeClass('loading').attr('disabled', false).trigger('chosen:updated');
          };
          disableWithMessage = function(message) {
            return element.empty().append("<option selected>" + message + "</option>").attr('disabled', true).trigger('chosen:updated');
          };
          $timeout(function() {
            return element.chosen(options);
          });
          if (ctrl) {
            origRender = ctrl.$render;
            ctrl.$render = function() {
              origRender();
              return element.trigger('chosen:updated');
            };
            if (attr.multiple) {
              viewWatch = function() {
                return ctrl.$viewValue;
              };
              scope.$watch(viewWatch, ctrl.$render, true);
            }
          }
          attr.$observe('disabled', function(value) {
            return element.trigger('chosen:updated');
          });
          if (attr.ngOptions) {
            match = attr.ngOptions.match(NG_OPTIONS_REGEXP);
            valuesExpr = match[7];
            if (angular.isUndefined(scope.$eval(valuesExpr))) {
              startLoading();
            }
            return scope.$watch(valuesExpr, function(newVal, oldVal) {
              if (newVal !== oldVal) {
                stopLoading();
                if (isEmpty(newVal)) {
                  return disableWithMessage(options.no_results_text || 'No values available');
                }
              }
            });
          }
        }
      };
    }
  ]);

}).call(this);
