path = require('path')
rootPath = path.normalize(__dirname + '/../..')

# general settings
module.exports =
	root: rootPath,
	port: process.env.PORT || 3000,
	db: process.env.MONGOHQ_URL