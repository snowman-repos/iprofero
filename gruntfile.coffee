module.exports = (grunt) ->
	grunt.initConfig
		pkg: grunt.file.readJSON("package.json")
		watch:

			coffeescriptwatch:
				files: [ "client/app/**/*.coffee", "api/**/*.coffee" ]
				tasks: [ "coffeelint", "coffee" ]
				options:
					livereload: true

			styluswatch:
				files: [ "client/styles/**/*" ]
				tasks: [ "stylus", "kss" ]
				options:
					livereload: true

			jadewatch:
				files: [ "api/views/**/*", "client/views/**/*" ]
				tasks: [ "jade" ]
				options:
					livereload: true

			htmlwatch:
				files: [ "public/views/**" ]
				options:
					livereload: true

			csswatch:
				files: [ "public/css/**" ]
				options:
					livereload: true

			jswatch:
				files: [ "public/js/**" ]
				options:
					livereload: true

		coffee:
			compile:
				expand: true
				cwd: "./client/app/"
				src: "**/*.coffee"
				dest: "public/js"
				ext: ".js"

		jade:
			compile:
				expand: true
				cwd: "./client/views/"
				src: "**/*.jade"
				dest: "public/views"
				ext: ".html"

		stylus:
			compile:
				expand: false
				src: [ "client/styles/app.styl" ]
				dest: "public/css/app.css"
				ext: ".css"

		kss:
			files:
				src: 'client/styles/'
				dest: 'public/styleguide/'
			options:
				preprocessor: 'stylus'
				template: 'client/styles/styleguide-template/'

		coffeelint:
			files: [
				"gruntfile.coffee",
				"client/app/**/*.coffee",
				"test/**/*.coffee",
				"api/**/*.coffee"
			]
			options:
				indentation:
					level: "ignore"
				max_line_length:
					value: 80
					level: "error"
				newlines_after_classes:
					level: "error"
				no_stand_alone_at:
					level: "error"
				no_tabs:
					level: "ignore"

		cssmin:
			combine:
				options:
					report: "gzip"
					banner: '/*! <%= pkg.name %> - v<%= pkg.version %>
					 - <%= grunt.template.today("yyyy-mm-dd") %> */'
				files:
					"./public/css/main.min.css": ["./public/lib/semantic-ui/css/semantic.css",
					 "./public/css/app.css"]

		uglify:
			combine:
				options:
					mangle: false
					report: "gzip"
					except: ["jQuery", "$", "_"]
					banner: '/*! <%= pkg.name %> - v<%= pkg.version %>
					 - <%= grunt.template.today("yyyy-mm-dd") %> */'
				files:
					"./public/js/main.min.js": [
						"./public/lib/jquery/jquery.js"
						"./public/lib/md5.js"
						"./public/lib/md5.js"
						"./public/lib/semantic-ui/javascript/semantic.min.js"
						"./public/lib/angular/angular.js"
						"./public/lib/angular-cookies/angular-cookies.js"
						"./public/lib/angular-resource/angular-resource.js"
						"./public/lib/angular-ui-utils/modules/route.js"
						"./public/lib/angular-ui-utils/modules/mask.js"
						"./public/lib/angular-xeditable/xeditable.min.js"
						"./public/lib/underscore/underscore-min.js"
						"./public/lib/underscore.string/dist/underscore.string.min.js"
						"./public/lib/angulartics/angulartics.js"
						"./public/lib/angulartics/angulartics-google-analytics.js"
						"./public/lib/ngTagsInput/src/ng-tags-input.js"
						"./public/lib/angular-bootstrap/ui-bootstrap-tpls.js"
						"./public/lib/formatter/lib/jquery.formatter.js"
						"./public/lib/momentjs/moment.js"
						"./public/lib/angular-momentjs/angular-momentjs.js"
						"./public/lib/angular-datepicker/angular-date-picker.js"
						"./public/js/app.js"
						"./public/js/routes.js"
						"./public/js/global/services/GlobalServices.js"
						"./public/js/global/services/JobService.js"
						"./public/js/global/services/SkillService.js"
						"./public/js/global/services/TeamService.js"
						"./public/js/global/services/TechnologyService.js"
						"./public/js/global/services/ActivityService.js"
						"./public/js/global/controllers/IndexController.js"
						"./public/js/global/controllers/HeaderController.js"
						"./public/js/global/controllers/SidebarController.js"
						"./public/js/global/directives/GlobalDirectives.js"
						"./public/js/global/filters/GlobalFilters.js"
						"./public/js/users/services/UsersService.js"
						"./public/js/users/controllers/UsersController.js"
						"./public/js/users/directives/UsersDirectives.js"
						"./public/js/projects/services/ProjectsService.js"
						"./public/js/projects/controllers/ProjectsController.js"
						"./public/js/projects/directives/ProjectsDirectives.js"
						"./public/js/timesheets/services/TimesheetsService.js"
						"./public/js/timesheets/controllers/TimesheetsController.js"
						"./public/js/admin/controllers/AdminController.js"
						"./public/js/admin/directives/AdminDirectives.js"
						"./public/js/admin/controllers/ReportsController.js"
						"./public/js/init.js"
					]

		# requirejs:
		# 	compile:
		# 		options:
		# 			baseUrl: "./public"
		# 			mainConfigFile: "./public/js/requirejs.config.js"
		# 			out: "./public/js/main.min.js"
		# 			done: (done, output) ->
		# 				duplicates = require('rjs-build-analysis').duplicates(output)
		# 				if duplicates.length > 0
		# 					grunt.log.subhead "Duplicates found in requirejs build:"
		# 					grunt.log.warn(duplicates)
		# 					done(new Error "r.js built duplicate modules, please check
		# 					 the excludes option.")

		nodemon:
			dev:
				options:
					file: "server.coffee"
					args: []
					ignoredFiles: [ "README.md", "node_modules/**", ".DS_Store" ]
					watchedExtensions: [ "coffee" ]
					watchedFolders: [ "app", "config" ]
					debug: true
					delayTime: 1
					env:
						PORT: 3000

					cwd: __dirname
			prod:
				options:
					file: "server.coffee"
					args: []
					ignoredFiles: [ "README.md", "node_modules/**", ".DS_Store" ]
					watchedExtensions: [ "coffee" ]
					watchedFolders: [ "app", "config" ]
					debug: true
					delayTime: 1
					env:
						PORT: 80

					cwd: __dirname

		concurrent:
			tasks: [ "nodemon:dev", "watch" ]
			options:
				logConcurrentOutput: true

		mochaTest:
			options:
				reporter: "spec"

			src: [ "test/api/test/**/*.coffee" ]

		karma:
			unit:
				configFile: 'karma.conf.coffee'
				autoWatch: true
				background: true

		bower:
			install:
				options:
					targetDir: "./public/lib"
					layout: "byComponent"
					install: true
					verbose: true
					cleanBowerDir: true

	grunt.loadNpmTasks "grunt-contrib-watch"
	grunt.loadNpmTasks "grunt-coffeelint"
	grunt.loadNpmTasks "grunt-mocha-test"
	grunt.loadNpmTasks "grunt-karma"
	grunt.loadNpmTasks "grunt-nodemon"
	grunt.loadNpmTasks "grunt-newer"
	grunt.loadNpmTasks "grunt-concurrent"
	grunt.loadNpmTasks "grunt-kss"
	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.loadNpmTasks "grunt-contrib-jade"
	grunt.loadNpmTasks "grunt-contrib-stylus"
	grunt.loadNpmTasks "grunt-contrib-cssmin"
	grunt.loadNpmTasks "grunt-contrib-requirejs"
	grunt.loadNpmTasks "grunt-contrib-uglify"
	# grunt.loadNpmTasks "grunt-bower-task"
	grunt.option "force", true
	grunt.registerTask "default", [ "coffeelint", "concurrent" ]
	grunt.registerTask "test", [ "mochaTest", "karma" ]
	grunt.registerTask "install", [ "bower" ]
	grunt.registerTask "build", ["cssmin", "uglify"]
	grunt.registerTask "production", [ "cssmin", "nodemon:prod" ]

	grunt.event.on('watch', (action, filepath) ->
		grunt.log.writeln(filepath + ' has ' + action)
	)