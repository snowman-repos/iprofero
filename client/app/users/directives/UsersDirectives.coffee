# Directives for the Users module

# Enable/show the 'change avatar' modal
angular.module("iprofero.users").directive "avatarModal", ->
	(scope, element, attrs) ->
		setTimeout ->
			$(".change-avatar.modal").modal("attach events", ".avatar.edit", "show")
		, 1000

# Upload a file
angular.module("iprofero.users").directive "uploader", ->
	uploaderTemplate = "
		<div class='uploader'>

			<div class='ui action input'>
				<input class='ui fluid input' type='file' name='avatar'
				 ng-file-select='onFileSelect($files)'>
				<div class='ui icon button upload' data-ng-click='uploadAvatar()'>
					<i class='upload disk icon'></i>
					 upload
				</div>
			</div>
		
			<div class='progress' data-ng-show='progress!=0'>
				<div class='bar' style='width:{{progress}}%;'></div>
			</div>
		
		</div>
		
		<div data-ng-if='avatar' style='margin: 50px 0 0;'>
			<img data-ng-src='/uploads/{{avatar}}'>
		</div>
	"
	restrict: "E"
	# controller: [ "$scope", ($scope) ->

	# 	$scope.progress = 0
	# 	$scope.avatar = ""

	# 	$scope.sendFile = ->
			

	# 		# $form = $(el).parents('form')
	# 		# if $(el).val() == '' then return false

	# 		# $form.attr('action', $scope.action)

	# 		# $scope.apply ->
	# 		# 	$scope.progress = 0

	# # ]
	# link: (scope, elem, attrs, ctrl) ->

	# 	elem.find(".upload").on "click", ->
	# 		elem.find("input[type=submit]").click()

	replace: false
	template: uploaderTemplate


	# # scope: true
	# # link: (scope, element, attrs) ->
	# # 	element.bind "change", (event) ->
	# # 		files = event.target.files
	# # 		i = 0
	# # 		while i < files.length
	# # 			scope.$emit "fileSelected",
	# # 				file: files[i]
	# # 			i++