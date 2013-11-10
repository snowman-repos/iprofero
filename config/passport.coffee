# Authorisation strategies

mongoose = require('mongoose')
LocalStrategy = require('passport-local').Strategy
TwitterStrategy = require('passport-twitter').Strategy
FacebookStrategy = require('passport-facebook').Strategy
GitHubStrategy = require('passport-github').Strategy
GoogleStrategy = require('passport-google-oauth').OAuth2Strategy
LinkedinStrategy = require('passport-linkedin').Strategy
WeiboStrategy = require('passport-weibo').Strategy
User = mongoose.model('User')
config = require('./config')


module.exports = (passport) ->
	passport.serializeUser (user, done) ->
		done null, user.id

	passport.deserializeUser (id, done) ->
		User.findOne
			_id: id
		, (err, user) ->
			done err, user

	# Local - user-provided email/password

	passport.use new LocalStrategy(
		usernameField: "email"
		passwordField: "password"
	, (email, password, done) ->
		User.findOne
			email: email
		, (err, user) ->
			return done(err) if err
			unless user
				return done(null, false,
					message: "Unknown user"
				)
			unless user.authenticate(password)
				return done(null, false,
					message: "Invalid password"
				)
			done null, user
	)

	# Twitter

	passport.use new TwitterStrategy(
		consumerKey: config.twitter.clientID
		consumerSecret: config.twitter.clientSecret
		callbackURL: config.twitter.callbackURL
	, (token, tokenSecret, profile, done) ->
		User.findOne
			"twitter.id_str": profile.id
		, (err, user) ->
			return done(err) if err
			unless user
				user = new User(
					name: profile.displayName
					username: profile.username
					agency: "Profero"
					provider: "twitter"
					twitter: profile._json
					role: "user"
					active: true
				)
				user.save (err) ->
					console.log err if err
					done err, user
			else
				done err, user
	)

	# Facebook

	passport.use new FacebookStrategy(
		clientID: config.facebook.clientID
		clientSecret: config.facebook.clientSecret
		callbackURL: config.facebook.callbackURL
	, (accessToken, refreshToken, profile, done) ->
		User.findOne
			"facebook.id": profile.id
		, (err, user) ->
			return done(err) if err
			unless user
				user = new User(
					name: profile.displayName
					email: profile.emails[0].value
					username: profile.username
					agency: "Profero"
					provider: "facebook"
					facebook: profile._json
					role: "user"
					active: true
					contact:
						email: profile.emails[0].value
				)
				user.save (err) ->
					console.log err if err
					done err, user
			else
				done err, user
	)

	# Github

	passport.use new GitHubStrategy(
		clientID: config.github.clientID
		clientSecret: config.github.clientSecret
		callbackURL: config.github.callbackURL
	, (accessToken, refreshToken, profile, done) ->
		User.findOne
			"github.id": profile.id
		, (err, user) ->
			unless user
				user = new User(
					name: profile.displayName
					email: profile.emails[0].value
					username: profile.username
					agency: "Profero"
					provider: "github"
					github: profile._json
					role: "user"
					active: true
				)
				user.save (err) ->
					console.log err if err
					done err, user
			else
				done err, user
	)

	# Google

	passport.use new GoogleStrategy(
		clientID: config.google.clientID
		clientSecret: config.google.clientSecret
		callbackURL: config.google.callbackURL
	, (accessToken, refreshToken, profile, done) ->
		User.findOne
			"google.id": profile.id
		, (err, user) ->
			unless user
				user = new User(
					name: profile.displayName
					email: profile.emails[0].value
					username: profile.username
					agency: "Profero"
					provider: "google"
					google: profile._json
					role: "user"
					active: true
					contact:
						email: profile.emails[0].value
				)
				user.save (err) ->
					console.log err if err
					done err, user
			else
				done err, user
	)

	# Linkedin

	passport.use new LinkedinStrategy(
		consumerKey: config.linkedin.clientID
		consumerSecret: config.linkedin.clientSecret
		callbackURL: config.linkedin.callbackURL
	, (accessToken, refreshToken, profile, done) ->
		User.findOne
			"linkedin.id": profile.id
		, (err, user) ->
			unless user
				user = new User(
					name: profile.displayName
					username: profile.displayName
					agency: "Profero"
					provider: "linkedin"
					linkedin: profile._json
					role: "user"
					active: true
					avatar: ""
				)
				user.save (err) ->
					console.log err if err
					done err, user
			else
				done err, user
	)

	# Weibo

	passport.use new WeiboStrategy(
		clientID: config.weibo.clientID
		clientSecret: config.weibo.clientSecret
		callbackURL: config.weibo.callbackURL
	, (accessToken, refreshToken, profile, done) ->
		User.findOne
			"weibo.id": profile.id
		, (err, user) ->
			return done(err) if err
			unless user
				user = new User(
					name: profile.screenName
					username: profile.name
					agency: "Profero"
					provider: "weibo"
					weibo: profile._json
					role: "user"
					active: true
				)
				user.save (err) ->
					console.log err if err
					done err, user
			else
				done err, user
	)