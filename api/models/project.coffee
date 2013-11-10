mongoose = require("mongoose")
Schema = mongoose.Schema
crypto = require("crypto")
_ = require("underscore")

# Project Model

ProjectSchema = new Schema(
	name: String
	agency: String
	client: String
	description: String
	parent: {}
	account_manager: {}
	project_manager: {}
	sub_projects: []
	feedback: {}
	participants: []
	technologies: [String]
	screenshots: {}
	github: String
	urls:
		development: String
		testing: String
		staging: String
		production: String
	quote: String
	purchase_order: String
	invoice: String
	revenue:
		currency: String
		amount: Number
	cost: Number
	profit: Number
)

validatePresenceOf = (value) ->
	value and value.length

# Validation Rules

ProjectSchema.path("name").validate ((name) ->
	name.length
), "Name cannot be blank"

validatePresenceOf = (value) ->
	value and value.length


ProjectSchema.path("name").validate ((name) ->
	return true if name.length isnt 0
	name.length
), "Project name cannot be blank"

# Ensure no duplicate projects
ProjectSchema.path("name").validate ((name, fn) ->
	ProjectModel = mongoose.model("Project")
	ProjectModel.find
		name: name.toLowerCase()
	, (err, names) ->
		fn err or names.length is 0
), "Project already exists"

ProjectSchema.pre "save", (next) ->
	if not validatePresenceOf(@name)
		next new Error("Project Name Required")
	else
		next()

mongoose.model "Project", ProjectSchema