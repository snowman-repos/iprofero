mongoose = require('mongoose')
Technology = mongoose.model("Technology")

# Create new technology
exports.create = (req, res) ->
	technology = new Technology(req.body)
	technology.save (err) ->
		if err then res.send err else res.jsonp technology

# Fetch all technologies
exports.all = (req, res) ->
	Technology.find().exec (err, technologies) ->
		if err
			res.render err,
				status: 500
		else
			res.jsonp technologies

# Show single technology
exports.show = (req, res) ->
	technology = req.technology
	res.jsonp technology

# Fetch single technology
exports.technology = (req, res, next, id) ->
	Technology.findOne(_id: id).exec (err, technology) ->
		return next(err) if err
		return next(new Error("Failed to load Technology " + id)) unless technology
		req.technology = technology
		next()

# Delete single technology
exports.remove = (req, res) ->
	technology = req.technology
	Technology.findOne(_id: technology._id).remove (err, technology) ->
		if err
			res.render err,
				status: 500
		else
			res.send "OK"