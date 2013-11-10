_ = require('underscore')

# Load app configuration files - one for each environment
module.exports = _.extend(
	require(__dirname + '/../config/env/all.coffee'),
	require(__dirname + '/../config/env/' + process.env.NODE_ENV + '.json') || {}
)