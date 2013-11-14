# For storing and retrieving the user's preferences
angular.module("iprofero.timesheets").constant("prefix",
 "prefs-").factory "TimesheetPreferences", (prefix) ->

	set = (key, value) ->
		value = angular.toJson(value) if angular.isObject(value) or
		 angular.isArray(value)
		localStorage.setItem prefix + key, value

	get = (key) ->
		item = localStorage.getItem(prefix + key)
		return "" if not item or item is "null"
		return angular.fromJson(item) if item.charAt(0) is "{" or
		 item.charAt(0) is "["
		item

	remove = (key) ->
		localStorage.removeItem prefix + key

	getKeys = ->
		prefixLength = prefix.length
		keys = []
		for key of localStorage
			if key.substr(0, prefixLength) is prefix
				keys.push key.substr(prefixLength)
		keys

	clearPrefs = ->
		prefixLength = prefix.length
		for key of localStorage
			if key.substr(0, prefixLength) is prefix
				removeFromLocalStorage key.substr(prefixLength)
		true

	set: set
	get: get
	remove: remove
	getKeys: getKeys
	clearPrefs: clearPrefs