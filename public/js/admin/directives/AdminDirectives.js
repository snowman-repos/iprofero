(function() {
  angular.module("iprofero.admin").directive("validateActivity", function() {
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
              prompt: 'Please enter a name'
            }
          ]
        }
      };
      element.form(validationRules, {
        inline: true,
        on: "blur",
        onSuccess: function() {
          return scope.addActivity();
        }
      });
      return element.find(".button").on("click", function() {
        return element.form('validate form');
      });
    };
  });

}).call(this);
