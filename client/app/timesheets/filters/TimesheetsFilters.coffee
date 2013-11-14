# Timesheet filters

getHoursMinutesSeconds = (time) ->

	# hours = Math.floor(time)
	# minutes = 60 * (time - hours)
	# seconds = Math.floor(60 * (minutes - Math.floor(minutes)))
	# minutes = Math.floor(60 * (time - hours))

	minutes = Math.floor(time/60)
	hours = Math.floor(minutes / 60)
	minutes = minutes - (hours*60)
	seconds = time - (hours*60*60) - (minutes*60)

	leadingZero = (n) ->
		if n < 10
			"0" + n
		else
			n

	[
		leadingZero(hours)
	,
		leadingZero(minutes)
	,
		leadingZero(seconds)
	]

# input for this comes from the range input
angular.module("iprofero.timesheets").filter "time", ->
	(input) ->

		if input
			time = getHoursMinutesSeconds(input)

			time[0] + "h " + time[1] + "m " + time[2] + "s"
		else "0h 0m 0s"

# input for this comes from the stopwatch factory
angular.module("iprofero.timesheets").filter "duration", ->
	(input) ->

		if input
			time = getHoursMinutesSeconds(input)

			time[0] + ":" + time[1] + ":" + time[2]
		else "00:00:00"