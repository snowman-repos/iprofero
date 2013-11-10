mongoose = require("mongoose")
User = mongoose.model("User")
_ = require("underscore")

# When the user is authorised
exports.authCallback = (req, res, next) ->
	res.redirect "/"

# Sign in Page
exports.signin = (req, res) ->
	res.render "users/signin",
		title: "Signin"
		message: req.flash("error")

# Sign up Page
exports.signup = (req, res) ->
	res.render "users/signup",
		title: "Sign up"
		user: new User()

# Sign out process
exports.signout = (req, res) ->
	req.logout()
	res.redirect "/"

# Authorisation process
exports.session = (req, res) ->
	res.redirect "/"

# Create new user
exports.create = (req, res) ->
	user = new User(req.body)
	# This is only called when the user uses a local
	# authorisation strategy
	user.provider = "local"
	user.active = true
	user.contact.email = user.email
	# Set default avatar, in case gravatar exists
	user.avatar = "http://gravatar.com/avatar/" + md5(user.email)
	user.save (err) ->
		if err
			return res.render("users/signup",
				errors: err.errors
				user: user
			)
		req.logIn user, (err) ->
			return next(err) if err
			res.redirect "/welcome"

# Show single user profile
exports.show = (req, res) ->
	if req.user and req.user.role == "admin"
		user = req.profile
		res.jsonp user
	else
		# only return a subset of user data for non-admins
		user =
			_id: req.profile._id
			agencies: req.profile.agencies
			agency: req.profile.agency
			avatar: req.profile.avatar
			email: req.profile.email
			job_title: req.profile.job_title
			job_titles: req.profile.job_titles
			name: req.profile.name
			provider: req.profile.provider
			team: req.profile.team
			username: req.profile.username
			skills: req.profile.skills
			projects: req.profile.projects
			employment_period: req.profile.employment_period
		res.jsonp user

# Fetch single user profile
exports.user = (req, res, next, id) ->
	User.findOne(_id: id).exec (err, user) ->
		return next(err) if err
		return next(new Error("Failed to load User " + id)) unless user
		req.profile = user
		next()

# Fetch all user profiles
exports.all = (req, res) ->
	User.find().sort("-created").populate("user").exec (err, users) ->
		if err
			res.render "error",
				status: 500
		else
			res.jsonp users

# Return single user profile
exports.profile = (req, res) ->
	res.jsonp req.profile or null

# Return profile for the logged in user
exports.me = (req, res) ->
	res.jsonp req.user or null

# Update single user profile
exports.update = (req, res) ->
	if req.user._id is req.body._id
		user = req.user
		user = _.extend(user, req.body)
		user.save (err) ->
			if err
				res.render "error",
					status: 500
			else
				res.jsonp user
	else
		User.findOne(_id: req.body._id).exec (err, user) ->
			return next(err) if err
			return next(new Error("Failed to update User " + id)) unless user
			user = _.extend(user, req.body)
			user.save (err) ->
				if err
					res.render "error",
						status: 500
				else
					res.jsonp user

# Delete user
exports.remove = (req, res) ->
	user = req.profile
	User.findOne(_id: user._id).remove (err, user) ->
		if err
			res.render err,
				status: 500
		else
			res.send "OK"