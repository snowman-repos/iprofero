mongoose = require('mongoose')
Skill = mongoose.model("Skill")

# Create new skill
exports.create = (req, res) ->
	skill = new Skill(req.body)
	skill.save (err) ->
		if err then res.send err else res.jsonp skill

# Fetch all skills
exports.all = (req, res) ->
	Skill.find().exec (err, skills) ->
		if err
			res.render err,
				status: 500
		else
			res.jsonp skills

# Show single skill
exports.show = (req, res) ->
	skill = req.skill
	res.jsonp skill

# Fetch single skill
exports.skill = (req, res, next, id) ->
	Skill.findOne(_id: id).exec (err, skill) ->
		return next(err) if err
		return next(new Error("Failed to load Skill " + id)) unless skill
		req.skill = skill
		next()

# Delete single skill
exports.remove = (req, res) ->
	skill = req.skill
	Skill.findOne(_id: skill._id).remove (err, skill) ->
		if err
			res.render err,
				status: 500
		else
			res.send "OK"