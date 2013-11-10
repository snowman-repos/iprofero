mongoose = require('mongoose')
Activity = mongoose.model("Activity")
_ = require("underscore")

# Create new activity
exports.create = (req, res) ->
	activity = new Activity(req.body)
	activity.save (err) ->
		if err then res.send err else res.jsonp activity

# Fetch all activities
exports.all = (req, res) ->
	Activity.find().exec (err, activities) ->
		if err
			res.render err,
				status: 500
		else
			res.jsonp activities

# Show single activity
exports.show = (req, res) ->
	activity = req.activity
	res.jsonp activity

# Delete single activity
exports.remove = (req, res) ->
	activity = req.activity
	Activity.findOne(_id: activity._id).remove (err, activity) ->
		if err
			res.render err,
				status: 500
		else
			res.send "OK"

# Update single activity
exports.update = (req, res) ->
	activity = req.activity
	activity.updated = true
	activity = _.extend(activity, req.body)
	activity.save (err) ->
		if err then res.send err else res.jsonp activity

# Fetch single activity
exports.activity = (req, res, next, id) ->
	Activity.findOne(_id: id).exec (err, activity) ->
		return next(err) if err
		return next(new Error("Failed to load Activity " + id)) unless activity
		req.activity = activity
		next()