should = require("should")
app = require("../../../../server")
mongoose = require("mongoose")
User = mongoose.model("User")
Project = mongoose.model("Project")

user = undefined
project = undefined

describe "<Unit Test>", ->
	describe "Model Project:", ->
		
		beforeEach (done) ->
			user = new User(
				name: "Full name"
				email: "test@test.com"
				username: "user"
				password: "password"
			)
			user.save (err) ->
				project = new Project(
					name: "Project Name"
					client: "Client"
				)
				done()

		describe "Method Save", ->
			it "should be able to save whithout problems", (done) ->
				project.save (err) ->
					should.not.exist err
					done()

			it "should be able to show an error when try to save witout name", (done) ->
				project.name = ""
				project.save (err) ->
					should.exist err
					done()

		afterEach (done) ->
			done()