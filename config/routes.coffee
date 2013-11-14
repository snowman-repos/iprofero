# API Routes

async = require("async")
module.exports = (app, passport, auth, profile) ->


	# Authentication Routes

	users = require("../api/controllers/users")
	app.post "/users/session", passport.authenticate("local",
		failureRedirect: "/signin"
		failureFlash: "Invalid email or password."
	), users.session
	app.get "/auth/facebook", passport.authenticate("facebook",
		scope: [ "email", "user_about_me" ]
		failureRedirect: "/signin"
	), users.signin
	app.get "/auth/facebook/callback", passport.authenticate("facebook",
		failureRedirect: "/signin"
	), users.authCallback
	app.get "/auth/github", passport.authenticate("github",
		failureRedirect: "/signin"
	), users.signin
	app.get "/auth/github/callback", passport.authenticate("github",
		failureRedirect: "/signin"
	), users.authCallback
	app.get "/auth/twitter", passport.authenticate("twitter",
		failureRedirect: "/signin"
	), users.signin
	app.get "/auth/twitter/callback", passport.authenticate("twitter",
		failureRedirect: "/signin"
	), users.authCallback
	app.get "/auth/google", passport.authenticate("google",
		failureRedirect: "/signin"
		scope: [ "https://www.googleapis.com/auth/userinfo.profile", "https://www.googleapis.com/auth/userinfo.email" ]
	), users.signin
	app.get "/auth/google/callback", passport.authenticate("google",
		failureRedirect: "/signin"
	), users.authCallback
	app.get "/auth/linkedin", passport.authenticate("linkedin",
		failureRedirect: "/signin"
	), users.signin
	app.get "/auth/linkedin/callback", passport.authenticate("linkedin",
		failureRedirect: "/signin"
	), users.authCallback
	app.get "/auth/weibo", passport.authenticate("weibo",
		failureRedirect: "/signin"
	), users.signin
	app.get "/auth/weibo/callback", passport.authenticate("weibo",
		failureRedirect: "/signin"
	), users.authCallback
	app.param "userId", users.user

	# User Routes

	app.get "/signin", users.signin
	app.get "/signup", users.signup
	app.get "/signout", users.signout
	app.get "/users", auth.requiresLogin, users.all
	app.post "/users", users.create
	app.get "/users/me", users.me
	app.get "/users/:userId", users.show
	app.put "/users/:userId", auth.requiresLogin, auth.user.hasAuthorization, users.update
	app.del "/users/:userId", auth.requiresLogin, auth.user.isAdmin, users.remove

	# Project Routes
	
	projects = require("../api/controllers/projects")
	app.get "/projects", auth.requiresLogin, projects.all
	app.post "/projects", auth.requiresLogin, auth.user.isAdmin, projects.create
	app.get "/projects/:projectId", auth.requiresLogin, projects.show
	app.put "/projects/:projectId", auth.requiresLogin, auth.user.isAdmin, projects.update
	app.del "/projects/:projectId", auth.requiresLogin, auth.user.isAdmin, projects.remove
	app.param("projectId", projects.project);

	# Timesheet Routes
	
	timesheets = require("../api/controllers/timesheets")
	app.get "/timesheets", auth.requiresLogin, timesheets.all
	app.post "/timesheets", auth.requiresLogin, timesheets.create
	app.get "/timesheets/:timesheetId", auth.requiresLogin, timesheets.show
	app.put "/timesheets/:timesheetId", auth.requiresLogin, timesheets.update
	app.del "/timesheets/:timesheetId", auth.requiresLogin, timesheets.remove
	app.get "/users/timesheets/:userId", auth.requiresLogin, timesheets.allForPerson
	app.get "/projects/timesheets/:projectId", auth.requiresLogin, timesheets.allForProject
	app.param("timesheetId", timesheets.timesheet)

	# Main Routes

	index = require("../api/controllers/index")
	app.get "/dashboard", auth.requiresLogin, profile.user.hasCompleteProfile, index.render
	app.get "/welcome", auth.requiresLogin, index.render
	app.get "/", index.render

	# Upload Routes

	pictures = require("../api/controllers/pictures")
	app.post "/avatar", auth.requiresLogin, pictures.upload

	# Job Routes

	jobs = require("../api/controllers/jobs")
	app.get "/jobs", auth.requiresLogin, jobs.all
	app.get "/jobs/:jobId", auth.requiresLogin, jobs.show
	app.post "/jobs", auth.requiresLogin, jobs.create
	app.del "/jobs/:jobId", auth.requiresLogin, auth.user.isAdmin, jobs.remove
	app.param("jobId", jobs.job);

	# Skill Routes

	skills = require("../api/controllers/skills")
	app.get "/skills", auth.requiresLogin, skills.all
	app.get "/skills/:skillId", auth.requiresLogin, skills.show
	app.post "/skills", auth.requiresLogin, skills.create
	app.del "/skills/:skillId", auth.requiresLogin, auth.user.isAdmin, skills.remove
	app.param("skillId", skills.skill);

	# Team Routes

	teams = require("../api/controllers/teams")
	app.get "/teams", auth.requiresLogin, teams.all
	app.get "/teams/:teamId", auth.requiresLogin, teams.show
	app.post "/teams", auth.requiresLogin, teams.create
	app.del "/teams/:teamId", auth.requiresLogin, auth.user.isAdmin, teams.remove
	app.param("teamId", teams.team);

	# Technology Routes

	technologies = require("../api/controllers/technologies")
	app.get "/technologies", auth.requiresLogin, technologies.all
	app.get "/technologies/:technologyId", auth.requiresLogin, technologies.show
	app.post "/technologies", auth.requiresLogin, technologies.create
	app.del "/technologies/:technologyId", auth.requiresLogin, auth.user.isAdmin, technologies.remove
	app.param("technologyId", technologies.technology);

	# Activity Routes

	activities = require("../api/controllers/activities")
	app.get "/activities", auth.requiresLogin, activities.all
	app.get "/activities/:activityId", auth.requiresLogin, activities.show
	app.post "/activities", auth.requiresLogin, auth.user.isAdmin, activities.create
	app.del "/activities/:activityId", auth.requiresLogin, auth.user.isAdmin, activities.remove
	app.put "/activities/:activityId", auth.requiresLogin, auth.user.isAdmin, activities.update
	app.param("activityId", activities.activity);