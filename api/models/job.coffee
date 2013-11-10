mongoose = require("mongoose")
Schema = mongoose.Schema

# Job Model

JobSchema = new Schema(
	title: String
)

validatePresenceOf = (value) ->
	value and value.length

# Validation Rules

JobSchema.path("title").validate ((title) ->
	return true if title.length isnt 0
	title.length
), "Job title cannot be blank"

# Ensure no duplicate jobs
JobSchema.path("title").validate ((title, fn) ->
	JobModel = mongoose.model("Job")
	JobModel.find
		title: title
	, (err, titles) ->
		fn err or titles.length is 0
), "Job already exists"

JobSchema.pre "save", (next) ->
	if not validatePresenceOf(@title)
		next new Error("Job Title Required")
	else
		next()

mongoose.model "Job", JobSchema