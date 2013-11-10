mongoose = require("mongoose")
Project = mongoose.model("Project")
_ = require("underscore")

# Create new project
exports.create = (req, res) ->
	project = new Project(req.body)
	project.save (err) ->
		if err
			return res.render("projects/new",
				errors: err.errors
				project: project
			)
		else
			res.jsonp project

# Show single project
exports.show = (req, res) ->
	if req.user.role == "admin"
		project = req.project
		res.jsonp project
	else
		# only return a subset of project data for non-admins
		project =
			_id: req.project._id
			name: req.project.name
			client: req.project.client
			description: req.project.description
			parent: req.project.parent
			account_manager: req.project.account_manager
			project_manager: req.project.project_manager
			isparent: req.project.isparent
			sub_projects: req.project.sub_projects
			feedback: req.project.feedback
			participants: req.project.participants
			technologies: req.project.technologies
			screenshots: req.project.screenshots
			github: req.project.github
			urls: req.project.urls
		res.jsonp project

# Fetch single project
exports.project = (req, res, next, id) ->
	Project.findOne(_id: id).exec (err, project) ->
		return next(err) if err
		return next(new Error("Failed to load Project " + id)) unless project
		req.project = project
		next()

# Fetch all projects
exports.all = (req, res) ->
	Project.find().sort("-created").populate("project").exec (err, projects) ->
		if err
			res.render "error",
				status: 500
		else
			res.jsonp projects

# Update single project
exports.update = (req, res) ->
	if req.project._id is req.body._id
		project = req.project
		project = _.extend(project, req.body)
		project.save (err) ->
			res.jsonp project
	else
		Project.findOne(_id: req.body._id).exec (err, project) ->
			return next(err) if err
			return next(new Error("Failed to update Project " + id)) unless project
			project = _.extend(project, req.body)
			project.save (err) ->
				res.jsonp project

# Delete project
exports.remove = (req, res) ->
	project = req.project
	Project.findOne(_id: project._id).remove (err, project) ->
		if err
			res.render err,
				status: 500
		else
			res.send "OK"