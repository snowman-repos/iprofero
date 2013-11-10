mongoose = require("mongoose")
Schema = mongoose.Schema

# Technology model

TechnologySchema = new Schema(
	name: String
)

validatePresenceOf = (value) ->
	value and value.length

# Validation Rules

TechnologySchema.path("name").validate ((name) ->
	return true if name.length isnt 0
	name.length
), "Technology name cannot be blank"

# Ensure no duplicate technologies
TechnologySchema.path("name").validate ((name, fn) ->
	TechnologyModel = mongoose.model("Technology")
	TechnologyModel.find
		name: name
	, (err, names) ->
		fn err or names.length is 0
), "Technology already exists"

TechnologySchema.pre "save", (next) ->
	if not validatePresenceOf(@name)
		next new Error("Technology Name Required")
	else
		next()

mongoose.model "Technology", TechnologySchema