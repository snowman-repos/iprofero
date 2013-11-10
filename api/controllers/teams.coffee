mongoose = require('mongoose')
Team = mongoose.model("Team")

# Create new team
exports.create = (req, res) ->
	team = new Team(req.body)
	team.save (err) ->
		if err then res.send err else res.jsonp team

# Fetch all teams
exports.all = (req, res) ->
	Team.find().exec (err, teams) ->
		if err
			res.render err,
				status: 500
		else
			res.jsonp teams

# Show single team
exports.show = (req, res) ->
	team = req.team
	res.jsonp team

# Fetch single team
exports.team = (req, res, next, id) ->
	Team.findOne(_id: id).exec (err, team) ->
		return next(err) if err
		return next(new Error("Failed to load Team " + id)) unless team
		req.team = team
		next()

# Delete single team
exports.remove = (req, res) ->
	team = req.team
	Team.findOne(_id: team._id).remove (err, team) ->
		if err
			res.render err,
				status: 500
		else
			res.send "OK"