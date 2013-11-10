# define [], () ->
# 	require.config
# 		packages: [
# 			'core'
# 			'dashboard/widgets/base'
# 		]
# 		paths:
# 			# 3rd Party Bower Libraries
# 			handlebars: "bower_components/require-handlebars-plugin/Handlebars"
# 			underscore: "bower_components/underscore-amd/underscore"
# 			jqueryui: "bower_components/jquery-ui/jqueryui"
# 		shim:
# 			bootstrap:
# 				deps: [ 'jquery' ]
# 				exports: 'jquery'
# 			markdown:
# 				exports: 'markdown'