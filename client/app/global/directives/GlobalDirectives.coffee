# Global directives that are used throughout the app

# ----------------------------------------
# 	CONTENTS
# ----------------------------------------

# 1.................FORMATTING
# 2.................KEYPRESS LISTENERS
# 3.................VALIDATION
# 4.................SEMANTIC UI COMPONENTS
# 5.................CUSTOM COMPONENTS

# ----------------------------------------
# 	FORMATTING
# ----------------------------------------

# Format dates
angular.module("iprofero.system").directive "formatDate", ->
	restrict: "A"
	link: (scope, element, attrs) ->
		element.on "blur", ->
			element.val(moment(element.val()).format("MMMM, YYYY"))

# ----------------------------------------
# 	KEYPRESS LISTENERS
# ----------------------------------------

# Run specified function on 'Enter' keypress
angular.module("iprofero.system").directive "onEnter", ->
	restrict: "A"
	link: (scope, element, attrs) ->
		element.on "keydown", (event) ->
			if event.which == 13
				scope.$apply attrs.onEnter

# Run specified function on 'Escape' keypress
angular.module("iprofero.system").directive "onEscape", ->
	restrict: "A"
	link: (scope, element, attrs) ->
		element.on "keydown", (event) ->
			if event.which == 27
				scope.$apply attrs.onEscape

# ----------------------------------------
# 	FORM VALIDATION
# ----------------------------------------

# Only allow numerical values
angular.module("iprofero.admin").directive "validNumber", ->
	require: "?ngModel"
	link: (scope, element, attrs, ngModelCtrl) ->
		return  unless ngModelCtrl
		ngModelCtrl.$parsers.push (val) ->
			clean = val.replace(/[^0-9,.]+/g, "")
			if val isnt clean
				ngModelCtrl.$setViewValue clean
				ngModelCtrl.$render()
			clean

		element.bind "keypress", (event) ->
			event.preventDefault() if event.keyCode is 32

# Validate welcome page form
angular.module("iprofero.system").directive "validateWelcome", ->
	restrict: "A"
	(scope, element, attrs) ->

		validationRules =
			email:
				identifier: 'email'
				rules: [
					type: 'email'
					prompt: 'Please enter a valid email'
				]
			telephone:
				identifier: 'telephone'
				rules: [
					type: 'empty'
					prompt: 'Please enter a telephone number'
				,
					type: 'length[10]'
					prompt: 'Telephone number must be at least 10 digits'
				]
			salary:
				identifier: 'salary'
				rules: [
					type: 'empty'
					prompt: 'Please enter your salary'
				]
			startdate:
				identifier: 'startdate'
				rules: [
					type: 'empty'
					prompt: 'Please enter your start date'
				]
			website:
				identifier: 'website'
				rules: [
					type: 'url'
					prompt: 'Website must be a URL'
				]

		phoneValid = attrs.validateWelcome != 1

		element.form validationRules,
			inline: true
			on: "blur"
			onValid: -> if @.get(0).id == "telephone"
				test = /^([0-9\(\)\/\+ \-]*)$/.test(@.get(0).value)
				if test then phoneValid = true

		element.find(".button").on "click", ->
			if element.form('validate form') && phoneValid
				scope.next()
			else
				$phone = element.find(".phone.field")
				if(!$phone.hasClass("error"))
					element.find(".phone.field").addClass "error"
					element.find(".phone.field").append('<div class="ui
					 red pointing prompt label transition visible">Please
					  enter a valid telephone number</div>')
				
# Validate login/registration forms
angular.module("iprofero.system").directive "validate", ->
	restrict: "A"
	(scope, element, attrs) ->

		validationRules =
			name:
				identifier: 'name'
				rules: [
					type: 'empty'
					prompt: 'Please enter your name'
				]
			email:
				identifier: 'email'
				rules: [
					type: 'email'
					prompt: 'Please enter a valid email'
				]
			username:
				identifier: 'username'
				rules: [
					type: 'empty'
					prompt: 'Please enter a username'
				]
			password:
				identifier: 'password'
				rules: [
					type: 'empty'
					prompt: 'Please enter a password'
				,
					type: 'length[6]'
					prompt: 'Your password must be at least 6 characters'
				]
			terms:
				identifier: 'terms'
				rules: [
					type: 'checked'
					prompt: 'You must agree to the terms and conditions'
				]

		element.form validationRules,
			inline: true
			on: "blur"

		element.on "submit", ->
			element.addClass "loading"

# ----------------------------------------
# 	RUN SEMANTIC UI COMPONENTS
# ----------------------------------------

# Run checkboxes
angular.module("iprofero.system").directive "checkbox", ->
	restrict: "A"
	link: (scope, element, attrs) ->
		element.checkbox()

# Run dimmers
angular.module("iprofero.system").directive "dimmer", ->
	(scope, element, attrs) ->
		element.on "click", (event) ->
			$('.dimmer').dimmer('show')

# Make something dismissable
angular.module("iprofero.system").directive "dismissable", ->
	(scope, element, attrs) ->
		element.find(".close.icon").bind "click", ->
			element.hide()

# Run sidebar
angular.module("iprofero.system").directive "sidebar", ->
	(scope, element, attrs) ->
		element.sidebar(
			debug: false
			performance: false
			verbose: false
		)

# Run dropdowns
angular.module("iprofero.system").directive "dropdown", ->
	(scope, element, attrs) ->
		element.dropdown()

		element.find(".menu").on "click", ->
			element.dropdown("hide")

# Toggle Sidebar
angular.module("iprofero.system").directive "toggleSidebar", ->
	(scope, element, attrs) ->

		menu = angular.element(document.querySelector('.sidebar'))

		element.bind "click", ->
			menu.sidebar('toggle')

# Close Sidebar
angular.module("iprofero.system").directive "closeSidebar", ->
	(scope, element, attrs) ->

		menu = angular.element(document.querySelector('.sidebar'))

		element.bind "click", ->
			if menu.sidebar('is open') then menu.sidebar('hide')

# ----------------------------------------
# 	CUSTOM COMPONENTS
# ----------------------------------------

# Multiselect list for projects
angular.module("iprofero.system").directive "multipleProjectSelect", ->

	listTemplate = "
		<div class='ui divided multi selection list'>
			<div class='item' data-ng-repeat='object in objects'
			 data-ng-click='toggleSelect(object)'
			 data-ng-class='{\"active\":values[object._id]}'>
				<input type='checkbox' data-ng-model='values[object._id]'
				 value='object._id'>
				<i class='large right floated check icon'
				 data-ng-show='values[object._id]'></i>
				<div class='content'>
					<div class='header' data-ng-bind='object.name'></div>
					<span data-ng-bind='object.client || \"client\"'></span>
				</div>
			</div>
		</div>
	"
	restrict: "E"
	replace: true
	template: listTemplate
	scope:
		values: "=values"
		objects: "=objects"
	link: (scope, element, attrs) ->
	controller: ($scope) ->

		$scope.toggleSelect = (object) ->
			$scope.values[object._id] = !$scope.values[object._id]

# Multi-select list for people
angular.module("iprofero.system").directive "multiplePeopleSelect", ->
	listTemplate = "
		<div class='ui divided multi selection list'>
			<div class='item' data-ng-repeat='object in objects'
			 data-ng-click='toggleSelect(object)'
			 data-ng-class='{\"active\":values[object._id]}'>
				<input type='checkbox' data-ng-model='values[object._id]'
				 value='object._id'>
				<i class='large floated left circular user icon'
				 data-ng-if='!object.avatar'></i>
				<img class='ui avatar image' data-ng-src='{{object.avatar}}'
				 data-ng-if='object.avatar'>
				<i class='large right floated check icon'
				 data-ng-show='values[object._id]'></i>
				<div class='content'>
					<div class='header' data-ng-bind='object.name'></div>
					<span data-ng-bind='object.job_title || \"job title\"'></span>
				</div>
			</div>
		</div>
	"
	restrict: "E"
	replace: true
	template: listTemplate
	scope:
		values: "=values"
		objects: "=objects"
	link: (scope, element, attrs) ->
	controller: ($scope) ->

		$scope.toggleSelect = (object) ->
			if $scope.$parent.okToToggle(object._id)
				$scope.values[object._id] = !$scope.values[object._id]

# Edit in place
angular.module("iprofero.system").directive "clickToEdit", ->
	editorTemplate = "
		<div class='click-to-edit'>
			<div data-ng-hide='view.editorEnabled'>
				<span>{{ value || default }}</span>
				<a class='edit-in-place' data-ng-click='enableEditor()'>
					<i class='pencil icon'></i>
				</a>
			</div>
			<div class='ui form' data-ng-show='view.editorEnabled'>
				<div class='ui action input'>
					<input on-enter='save()' on-escape='disableEditor()'
					 data-ng-model='view.editableValue' type='text'>
					<a class='ui icon teal button' data-ng-click='save()'>
						<i class='check icon'></i>
					</a>
					<a class='ui icon button' data-ng-click='disableEditor()'>
						<i class='remove icon'></i>
					</a>
				</div>
			</div>
		</div>"
	restrict: "A"
	replace: true
	template: editorTemplate
	scope:
		property: "@clickToEdit"
		value: "=clickToEdit"
		default: "=default"
		resource: "=resource"

	link: ($scope, element, attrs) ->
		$scope.$watch "view.editorEnabled", ->
			if $scope.view.editorEnabled is true
				element.find("input").focus()

	controller: ($scope) ->

		$scope.view =
			editableValue: $scope.value
			editorEnabled: false

		$scope.enableEditor = ->
			$scope.view.editorEnabled = true
			$scope.view.editableValue = $scope.value

		$scope.disableEditor = ->
			$scope.view.editorEnabled = false

		$scope.save = ->
			p = $scope.property
			actualProperty = p.substr(p.indexOf('.') + 1, p.length)
			$scope.value = $scope.view.editableValue

			if $scope.resource?
				$scope.resource[actualProperty] = $scope.value
				$scope.$parent.update($scope.resource)
				$scope.disableEditor()
			else
				$scope.$parent.updateSingleProperty(actualProperty, $scope.value)
				$scope.disableEditor()

# Edit in place (Headers)
angular.module("iprofero.system").directive "clickToEditHeadline", ->
	editorTemplate = "
		<div>
			<span data-ng-hide='view.editorEnabled' class='edit-in-place'
			 data-ng-click='enableEditor()'>{{ value || default }}</span>
			<div class='ui form' data-ng-show='view.editorEnabled'>
				<div class='ui action input'>
					<input on-enter='save()' on-escape='disableEditor()'
					 data-ng-model='view.editableValue' type='text'>
					<a class='ui icon teal button' data-ng-click='save()'>
						<i class='check icon'></i>
					</a>
					<a class='ui icon button' data-ng-click='disableEditor()'>
						<i class='remove icon'></i>
					</a>
				</div>
			</div>
		</div>"
	restrict: "A"
	replace: true
	template: editorTemplate
	scope:
		property: "@clickToEditHeadline"
		value: "=clickToEditHeadline"
		default: "=default"
		resource: "=resource"

	link: ($scope, element, attrs) ->

		$scope.$watch "view.editorEnabled", ->
			if $scope.view.editorEnabled is true
				element.find("input").focus()

	controller: ($scope) ->

		$scope.view =
			editableValue: $scope.value
			editorEnabled: false

		$scope.enableEditor = ->
			$scope.view.editorEnabled = true
			$scope.view.editableValue = $scope.value

		$scope.disableEditor = ->
			$scope.view.editorEnabled = false

		$scope.save = ->
			p = $scope.property
			actualProperty = p.substr(p.indexOf('.') + 1, p.length)
			$scope.value = $scope.view.editableValue

			if $scope.resource?
				$scope.resource[actualProperty] = $scope.value
				$scope.$parent.update($scope.resource)
				$scope.disableEditor()
			else
				$scope.$parent.updateSingleProperty(actualProperty, $scope.value)
				$scope.disableEditor()