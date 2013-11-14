# Validate new timelog form
angular.module("iprofero.timesheets").directive "validateTime", ->
	restrict: "A"
	(scope, element, attrs) ->

		$field = element.parent().parent()

		element.on "blur", ->
			testHours()

		testHours = ->
			$val = element.val()
			test = /^(?:([0-9.]|[1][0-9]|[2][0-3])([.]([1-9]|[0-9][1-9]))?)$/.test($val)
			if !test
				showHoursError()
				scope.invalidate()
			else
				element.addClass "valid"
				clearError()
				scope.validate()

		showHoursError = ->
			if(!$field.hasClass("error"))
				$field.addClass "error"
				$field.append('<div class="ui
				 red pointing prompt label transition visible">Please enter a number
				 between 0 and 24</div>')

		clearError = ->
			$field.removeClass "error"
			$field.find(".ui.red.label").remove()

# Chosen select inputs
angular.module("iprofero.timesheets").directive "chosen", [
	'$timeout',
	($timeout) ->

		# This is stolen from Angular...
		NG_OPTIONS_REGEXP =
		 /^\s*(.*?)(?:\s+as\s+(.*?))?(?:\s+group\s+by\s+(.*))?\s+for\s+(?:([\$\w][\$\w\d]*)|(?:\(\s*([\$\w][\$\w\d]*)\s*,\s*([\$\w][\$\w\d]*)\s*\)))\s+in\s+(.*)$/
	
		# Whitelist of options that will be parsed from the element's attributes and
		# passed into Chosen
		CHOSEN_OPTION_WHITELIST = [
			'noResultsText'
			'allowSingleDeselect'
			'disableSearchThreshold'
			'disableSearch'
			'enableSplitWordSearch'
			'inheritSelectClasses'
			'maxSelectedOptions'
			'placeholderTextMultiple'
			'placeholderTextSingle'
			'searchContains'
			'singleBackstrokeDelete'
			'displayDisabledOptions'
			'displaySelectedOptions'
			'width'
		]
	
		snakeCase = (input) -> input.replace /[A-Z]/g, ($1) -> "_#{$1.toLowerCase()}"
		isEmpty = (value) ->
			if angular.isArray(value)
				return value.length is 0
			else if angular.isObject(value)
				return false for key in value when value.hasOwnProperty(key)
			true
	
		chosen =
			restrict: 'A'
			require: '?ngModel'
			terminal: true
			link: (scope, element, attr, ctrl) ->
	
				# Take a hash of options from the chosen directive
				options = scope.$eval(attr.chosen) or {}
	
				# Options defined as attributes take precedence
				angular.forEach attr, (value, key) ->
					options[snakeCase(key)] =
					 scope.$eval(value) if key in CHOSEN_OPTION_WHITELIST
	
				startLoading = ->
					element.addClass('loading')
						.attr('disabled', true)
						.trigger('chosen:updated')
				stopLoading = ->
					element.removeClass('loading')
						.attr('disabled', false)
						.trigger('chosen:updated')
	
				disableWithMessage = (message) ->
					element
						.empty()
						.append("<option selected>#{message}</option>")
						.attr('disabled', true)
						.trigger('chosen:updated')
	
				# Init chosen on the next loop so ng-options can populate the select
				$timeout -> element.chosen options
	
				# Watch the underlying ng-model for updates and trigger an update
				# when they occur.
				if ctrl
					origRender = ctrl.$render
					ctrl.$render = ->
						origRender()
						element.trigger('chosen:updated')
	
					# This is basically taken from angular ngOptions source.
					# ngModel watches reference, not value, so when values are
					# added or removed from array ngModels, $render won't be fired.
					if attr.multiple
						viewWatch = -> ctrl.$viewValue
						scope.$watch viewWatch, ctrl.$render, true
	
				# Watch the disabled attribute (could be set by ngDisbaled)
				attr.$observe 'disabled', (value) ->
					element.trigger 'chosen:updated'
	
				# Watch the collection in ngOptions and update chosen when it changes.
				# This works with promises!
				if attr.ngOptions
					match = attr.ngOptions.match(NG_OPTIONS_REGEXP)
					valuesExpr = match[7]
	
					# There's no way to tell if the collection is a promise since
					# $parse hides this from us, so just assume it is a promise if
					# undefined, and show the loader
					startLoading() if angular.isUndefined(scope.$eval(valuesExpr))
					scope.$watch valuesExpr, (newVal, oldVal) ->
						unless newVal is oldVal
							stopLoading()
							if isEmpty(newVal)
								disableWithMessage(
									options.no_results_text || 'No values available'
								)
]