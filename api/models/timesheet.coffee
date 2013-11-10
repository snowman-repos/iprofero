mongoose = require("mongoose")
Schema = mongoose.Schema

# Timesheet fields
TimesheetSchema = new Schema(
	activity: String
	agency: String
	date: Date
	duration: Number
	person: String
	project: String
)

validatePresenceOf = (value) ->
	value and value.length

# Validation Rules

TimesheetSchema.pre "save", (next) ->
	if not validatePresenceOf(@date)
		next new Error("Timesheet Date Required")
	else
		next()

TimesheetSchema.path("date").validate ((date) ->
	return true if date.getMonth
	false
), "Timesheet date must be a date"

TimesheetSchema.pre "save", (next) ->
	if not validatePresenceOf(@duration)
		next new Error("Timesheet Duration Required")
	else
		next()

TimesheetSchema.path("duration").validate ((duration) ->
	return true if duration isnt 0
	false
), "Timesheet duration cannot be zero"

TimesheetSchema.pre "save", (next) ->
	if not validatePresenceOf(@person)
		next new Error("Timesheet Person Required")
	else
		next()

TimesheetSchema.path("person").validate ((person) ->
	return true if person.length isnt 0
	person.length
), "Timesheet person cannot be blank"

TimesheetSchema.pre "save", (next) ->
	if not validatePresenceOf(@project)
		next new Error("Timesheet Project Required")
	else
		next()

TimesheetSchema.path("project").validate ((project) ->
	return true if project.length isnt 0
	project.length
), "Timesheet project cannot be blank"

mongoose.model "Timesheet", TimesheetSchema