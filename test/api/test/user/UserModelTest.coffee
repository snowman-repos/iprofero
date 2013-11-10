should = require("should")
app = require("../../../../server")
mongoose = require("mongoose")
User = mongoose.model("User")

user = undefined

make_string = ->
	text = ""

	possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
	i = 0

	while i < 5
		text += possible.charAt(Math.floor(Math.random() * possible.length))
		i++
	text

make_email = ->
	make_string() + "@" + make_string() + ".com"

describe "<Unit Test>", ->
	describe "Model User:", ->
		
		before (done) ->
			user = new User(
				name: "Full name"
				email: make_email()
				username: "user"
				password: "password"
			)
			done()

		describe "Method Save", ->
			it "should be able to save whithout problems", (done) ->
				user.save (err) ->
					should.not.exist err
					done()

			it "should be able to show an error when try to save witout name", (done) ->
				user.name = ""
				user.save (err) ->
					should.exist err
					done()

		after (done) ->
			done()