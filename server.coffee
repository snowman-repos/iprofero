# basic requirements
express = require("express")
fs = require("fs")
passport = require("passport")
logger = require("mean-logger")

# configuration
env = process.env.NODE_ENV = process.env.NODE_ENV or "development"
config = require("./config/config")
auth = require("./config/middlewares/authorization")
profile = require("./config/middlewares/profile")
mongoose = require("mongoose")

# connect to database and require models
db = mongoose.connect(config.db)
models_path = __dirname + "/api/models"
fs.readdirSync(models_path).forEach (file) ->
	require models_path + "/" + file

# authentication
require("./config/passport") passport

# set up routing and middleware
app = express()
require("./config/express") app, passport
require("./config/routes") app, passport, auth, profile

# start the server
port = config.port
app.listen port
console.log "Express app started on port " + port
logger.init app, passport, mongoose
exports = module.exports = app