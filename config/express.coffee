express = require("express")
mongoStore = require("connect-mongo")(express)
flash = require("connect-flash")
helpers = require("view-helpers")
config = require("./config")

# configure express
module.exports = (app, passport) ->
	app.set "showStackError", true
	app.use express.compress(
		filter: (req, res) ->
			(/json|text|javascript|css/).test res.getHeader("Content-Type")
		level: 9
	)
	app.use express.favicon()
	app.use express.static(config.root + "/public")
	app.use express.logger("dev")  if process.env.NODE_ENV isnt "test"
	app.set "views", config.root + "/api/views"
	app.set "view engine", "jade"
	app.enable "jsonp callback"
	app.configure ->
		app.use express.cookieParser()
		app.use express.bodyParser(uploadDir:'/public/uploads')
		app.use express.methodOverride()
		app.use express.session(
			secret: "IPROFERO"
			store: new mongoStore(
				url: config.db
				collection: "sessions"
			)
		)
		app.use flash()
		app.use helpers(config.app.name)
		app.use passport.initialize()
		app.use passport.session()
		app.use app.router
		# ensure environment variable is available throughout the app
		app.locals
			env: process.env.NODE_ENV
		app.use (err, req, res, next) ->
			return next() if ~err.message.indexOf("not found")
			console.error err.stack
			res.status(500).render "500",
				error: err.stack
		app.use (req, res, next) ->
			res.status(404).render "404",
				url: req.originalUrl
				error: "Not found"