mongoose = require('mongoose')
Picture = mongoose.model("Picture")

# Save single picture
exports.upload = (req, res) ->
	console.log "HIT!!!"
	console.log req.files
	# picture = new Picture()
	# picture.set('avatar.file', req.files.avatar)
	# picture.save (err) ->
	# 	return next(err) if err
	# res.send 200