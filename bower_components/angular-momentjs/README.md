# angular-momentjs [![Build Status](https://travis-ci.org/gdi2290/angular-momentjs.png?branch=master)](https://travis-ci.org/gdi2290/angular-momentjs)

Moment.js with Angular.js

#How do I add this to my project?

You can download angular-momentjs by:

* (prefered) Using bower and running `bower install angular-momentjs --save`
* Using npm and running `npm install angular-momentjs --save`
* Downloading it manually by clicking [here to download development unminified version](https://raw.github.com/gdi2290/angular-momentjs/master/angular-momentjs.js)


````html
<body ng-app="YOUR_APP" ng-controller="MainCtrl">
 {{ time }}
  or
 {{ anotherTime }}
</body>
<script src="http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.3.1/moment.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.2.0-rc.3/angular.min.js"></script>
<script src="app/bower_components/angular-momentjs/angular-momentjs.js"></script>
<script>
  angular.module('YOUR_APP', [
    'angular-momentjs',
    'controllers'
  ]) // you're able to set Default settings
  .config(function(MomentProvider){
    MomentProvider
      .asyncLoading(false)
      .scriptUrl('//cdnjs.cloudflare.com/ajax/libs/moment.js/2.3.1/moment.min.js');
  });

  angular.module('controllers', [])
    .controller('MainCtrl', function($scope, Moment) {
      // If didn't set asyncLoading angular-momentjs will assumeyou provided the moment.js
      $scope.time = Moment("20111031", "YYYYMMDD").fromNow();

      // If set asyncLoading to true then angular-momentjs will inject the script and return a $moment promise
      Moment.then(function(moment) {
        $scope.anotherTime = moment("20111031", "YYYYMMDD").fromNow();
      })
    });
</script>

````
