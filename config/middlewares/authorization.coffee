# Authorisation middlewares

# check the user is logged in
exports.requiresLogin = (req, res, next) ->
	return res.send(401, "User is not authorized") unless req.isAuthenticated()
	next()

exports.user = 

	# check the user has authorisation for the action
	# (e.g. they are either admin or viewing/editing their own
	# person information)
	hasAuthorization: (req, res, next) ->
		return res.send(401, "User is not authorized") unless ((req.profile.id is req.user.id) or (req.user.role is "admin"))
		next()

	# check the user is admin
	isAdmin: (req, res, next) ->
		return res.send(401, "User is not admin") unless req.user.role is "admin"
		next()