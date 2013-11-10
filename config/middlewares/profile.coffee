# Profile middleware

exports.user = 

	# check user has a complete profile
	hasCompleteProfile: (req, res, next) ->
		if (req.user.email? and req.user.contact.telephone? and req.user.job_title?)
			if (req.user.email is "" or req.user.contact.telephone is "" or req.user.job_title is "")
				return res.redirect("/welcome")
		else
			return res.redirect("/welcome")
		next()