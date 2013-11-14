mongoose = require("mongoose")
Schema = mongoose.Schema

# Timesheet fields
TimesheetSchema = new Schema(
	activity: String
	agency: String
	date: Date
	hours: Number
	person: String
	project: String
	comment: String
)

validatePresenceOf = (value) ->
	value and value.length

# Validation Rules

TimesheetSchema.path("date").validate ((date) ->
	return true if date.getMonth
	false
), "Timesheet date must be a date"

TimesheetSchema.path("hours").validate ((hours) ->
	return true if hours isnt 0
	false
), "Timesheet hours cannot be zero"

TimesheetSchema.path("person").validate ((person) ->
	return true if person.length isnt 0
	person.length
), "Timesheet person cannot be blank"

TimesheetSchema.path("project").validate ((project) ->
	return true if project.length isnt 0
	project.length
), "Timesheet project cannot be blank"


TimesheetSchema.pre "save", (next) ->
	if not validatePresenceOf(@date)
		next new Error("Timesheet Date Required")
	else if not validatePresenceOf(@person)
		next new Error("Timesheet Person Required")
	else if not validatePresenceOf(@project)
		next new Error("Timesheet Project Required")
	else if not validatePresenceOf(@hours)
		next new Error("Timesheet Hours Required")
	else
		next()

mongoose.model "Timesheet", TimesheetSchema