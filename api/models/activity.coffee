mongoose = require("mongoose")
Schema = mongoose.Schema

# Activity model

ActivitySchema = new Schema(
	agency: String
	name: String
	billable: Boolean
	parent:
		id: String
		name: String
	rate: Number
	isparent: Boolean
)

validatePresenceOf = (value) ->
	value and value.length

# Validation Rules

ActivitySchema.path("name").validate ((name) ->
	return true if name.length isnt 0
	name.length
), "Activity name cannot be blank"

# Ensure no duplicate activities
ActivitySchema.path("name").validate ((name, fn) ->
	return fn(true) if @updated
	ActivityModel = mongoose.model("Activity")
	ActivityModel.find
		name: name
	, (err, names) ->
		fn err or names.length is 0
), "Activity already exists"

ActivitySchema.pre "save", (next) ->
	if not validatePresenceOf(@name)
		next new Error("Activity Name Required")
	else
		next()

mongoose.model "Activity", ActivitySchema