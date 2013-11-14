# Stopwatch model

angular.module("iprofero.timesheets").constant("COUNTER",
 1000).factory "Stopwatch", (COUNTER, $timeout) ->
	data =
		status: "off"
		value: 0

	stopwatch = null
	start = ->
		data.status = "on"
		stopwatch = $timeout(->
			data.value++
			start()
		, COUNTER)

	stop = ->
		if data.status == "paused" then start()
		else
			data.status = "paused"
			$timeout.cancel stopwatch
			stopwatch = null

	reset = ->
		data.status = "off"
		$timeout.cancel stopwatch
		stopwatch = null
		data.value = 0

	data: data
	start: start
	stop: stop
	reset: reset