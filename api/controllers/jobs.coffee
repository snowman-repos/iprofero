mongoose = require('mongoose')
Job = mongoose.model("Job")

# Create new job
exports.create = (req, res) ->
	job = new Job(req.body)
	job.save (err) ->
		if err then res.send err else res.jsonp job

# Fetch all jobs
exports.all = (req, res) ->
	Job.find().exec (err, jobs) ->
		if err
			res.render err,
				status: 500
		else
			res.jsonp jobs

# Show single job
exports.show = (req, res) ->
	job = req.job
	res.jsonp job

# Fetch single job
exports.job = (req, res, next, id) ->
	Job.findOne(_id: id).exec (err, job) ->
		return next(err) if err
		return next(new Error("Failed to load Job " + id)) unless job
		req.job = job
		next()

# Delete single job
exports.remove = (req, res) ->
	job = req.job
	Job.findOne(_id: job._id).remove (err, job) ->
		if err
			res.render err,
				status: 500
		else
			res.send "OK"