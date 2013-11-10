mongoose = require("mongoose")
Schema = mongoose.Schema

# Team model

TeamSchema = new Schema(
	name: String
)

validatePresenceOf = (value) ->
	value and value.length

# Validation Rules

TeamSchema.path("name").validate ((name) ->
	return true if name.length isnt 0
	name.length
), "Team name cannot be blank"

# Ensure no duplicate teams
TeamSchema.path("name").validate ((name, fn) ->
	TeamModel = mongoose.model("Team")
	TeamModel.find
		name: name
	, (err, names) ->
		fn err or names.length is 0
), "Team already exists"

TeamSchema.pre "save", (next) ->
	if not validatePresenceOf(@name)
		next new Error("Team Name Required")
	else
		next()

mongoose.model "Team", TeamSchema