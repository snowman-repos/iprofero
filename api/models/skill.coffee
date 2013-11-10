mongoose = require("mongoose")
Schema = mongoose.Schema

# Skill model

SkillSchema = new Schema(
	name: String
)

validatePresenceOf = (value) ->
	value and value.length

# Validation Rules

SkillSchema.path("name").validate ((name) ->
	return true if name.length isnt 0
	name.length
), "Skill name cannot be blank"

# Ensure no duplicate skills
SkillSchema.path("name").validate ((name, fn) ->
	SkillModel = mongoose.model("Skill")
	SkillModel.find
		name: name
	, (err, names) ->
		fn err or names.length is 0
), "Skill already exists"

SkillSchema.pre "save", (next) ->
	if not validatePresenceOf(@name)
		next new Error("Skill Name Required")
	else
		next()

mongoose.model "Skill", SkillSchema