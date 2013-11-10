# Admin directives used within the admin module

# Validate admin settings page activity form
# NOTE: currently not used because it requires the model to be changed
# before the form can be submitted - bug
angular.module("iprofero.admin").directive "validateActivity", ->
	restrict: "A"
	(scope, element, attrs) ->

		validationRules =
			name:
				identifier: 'name'
				rules: [
					type: 'empty'
					prompt: 'Please enter a name'
				]

		element.form validationRules,
			inline: true
			on: "blur"
			onSuccess: ->
				scope.addActivity()

		element.find(".button").on "click", ->
			element.form('validate form')