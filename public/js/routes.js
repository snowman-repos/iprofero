(function() {
  window.app.config([
    "$routeProvider", function($routeProvider) {
      return $routeProvider.when("/timesheets", {
        templateUrl: "views/timesheets/index.html"
      }).when("/projects", {
        templateUrl: "views/projects/list.html"
      }).when("/projects/new", {
        templateUrl: "views/projects/create.html"
      }).when("/projects/:projectId", {
        templateUrl: "views/projects/view.html"
      }).when("/projects/edit/:projectId", {
        templateUrl: "views/projects/edit.html"
      }).when("/people", {
        templateUrl: "views/users/list.html"
      }).when("/people/:userId", {
        templateUrl: "views/users/view.html"
      }).when("/profile/:userId", {
        templateUrl: "/views/users/view.html"
      }).when("/me", {
        templateUrl: "views/users/profile.html"
      }).when("/dashboard", {
        templateUrl: "views/dashboard.html"
      }).when("/welcome", {
        templateUrl: "views/welcome.html"
      }).when("/", {
        templateUrl: "views/index.html"
      }).when("/admin/settings", {
        templateUrl: "views/admin/settings.html"
      }).when("/admin/reports", {
        templateUrl: "views/admin/reports.html"
      }).otherwise({
        redirectTo: "/"
      });
    }
  ]);

  window.app.config([
    "$locationProvider", function($locationProvider) {
      return $locationProvider.html5Mode(false).hashPrefix('!');
    }
  ]);

  window.app.run(function($rootScope, $location, $cookieStore, Global) {
    var checkAdmin, checkAuth, routesThatDontRequireAuth, routesThatRequireAdmin;
    routesThatDontRequireAuth = ['/profile', '/signin'];
    routesThatRequireAdmin = ['/admin/reports', '/projects/create', '/projects/edit'];
    checkAuth = function(route) {
      return _.find(routesThatDontRequireAuth, function(noAuthRoute) {
        return _.str.startsWith(route, noAuthRoute);
      });
    };
    checkAdmin = function(route) {
      return _.find(routesThatRequireAdmin, function(adminRoute) {
        return _.str.startsWith(route, adminRoute);
      });
    };
    return $rootScope.$on("$routeChangeStart", function(event, next, current) {
      if (!checkAuth($location.url()) && !Global.user) {
        $location.path("/");
      }
      if (checkAdmin($location.url()) && Global.user.role !== "admin") {
        $location.path("/notadmin");
      }
      if ($location.url() === "/" && Global.user) {
        return $location.path("/dashboard");
      }
    });
  });

}).call(this);
