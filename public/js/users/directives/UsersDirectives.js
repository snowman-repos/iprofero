(function() {
  angular.module("iprofero.users").directive("avatarModal", function() {
    return function(scope, element, attrs) {
      return setTimeout(function() {
        return $(".change-avatar.modal").modal("attach events", ".avatar.edit", "show");
      }, 1000);
    };
  });

  angular.module("iprofero.users").directive("uploader", function() {
    var uploaderTemplate;
    uploaderTemplate = "		<div class='uploader'>			<div class='ui action input'>				<input class='ui fluid input' type='file' name='avatar'				 ng-file-select='onFileSelect($files)'>				<div class='ui icon button upload' data-ng-click='uploadAvatar()'>					<i class='upload disk icon'></i>					 upload				</div>			</div>					<div class='progress' data-ng-show='progress!=0'>				<div class='bar' style='width:{{progress}}%;'></div>			</div>				</div>				<div data-ng-if='avatar' style='margin: 50px 0 0;'>			<img data-ng-src='/uploads/{{avatar}}'>		</div>	";
    return {
      restrict: "E",
      replace: false,
      template: uploaderTemplate
    };
  });

}).call(this);
