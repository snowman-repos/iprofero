mongoose = require("mongoose")
Timesheet = mongoose.model("Timesheet")
_ = require("underscore")

# create new timesheet
exports.create = (req, res) ->
	timesheet = new Timesheet(req.body)
	if timesheet.person == req.user.id
		timesheet.save (err) ->
			if err
				res.render "500",
					errors: err.errors
					status: 500
			else
				res.jsonp timesheet
	else
		res.render "error",
			errors: "You are not authorised to do this..."
			status: 400

# return single timesheet
exports.show = (req, res) ->
	timesheet = req.timesheet
	res.jsonp timesheet

# return all timesheets
exports.all = (req, res) ->
	Timesheet.find().exec (err, timesheets) ->
		if err
			res.render "500",
				error: err
				status: 500
		else
			res.jsonp timesheets

exports.allForPerson = (req, res) ->
	person = req.profile
	Timesheet.find(person: person._id).exec (err, timesheets) ->
		if err
			res.render "500",
				error: err
				status: 500
		else
			# group these by date
			res.jsonp timesheets

exports.allForProject = (req, res) ->
	project = req.project
	Timesheet.find(project: project._id).exec (err, timesheets) ->
		if err
			res.render "500",
				error: err
				status: 500
		else
			res.jsonp timesheets


# update single timesheet
exports.update = (req, res) ->
	timesheet = req.timesheet
	if timesheet.person == req.user.id
		timesheet = _.extend(timesheet, req.body)
		timesheet.save (err) ->
			if err
				res.render "500",
					error: err
					status: 500
			else
				res.jsonp timesheet
	else
		res.render "error",
			errors: "You are not authorised to do this..."
			status: 400

# remove single timesheet
exports.remove = (req, res) ->
	timesheet = req.timesheet
	Timesheet.findOne(_id: timesheet._id).remove (err, timesheet) ->
		if err
			res.render err,
				error: err
				status: 500
		else
			res.send "OK"

# fetch single timesheet
exports.timesheet = (req, res, next, id) ->
	Timesheet.findOne(_id: id).exec (err, timesheet) ->
		return next(err) if err
		return next(new Error("Failed to load Timesheet " + id)) unless timesheet
		req.timesheet = timesheet
		next()