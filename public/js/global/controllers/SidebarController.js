(function() {
  angular.module("iprofero.system").controller("SidebarController", [
    "$scope", "Global", function($scope, Global) {
      $scope.global = Global;
      $scope.menu = [
        {
          title: "People",
          link: "people",
          icon: "users"
        }, {
          title: "Projects",
          link: "projects",
          icon: "briefcase",
          submenu: [
            {
              title: "All Projects",
              link: "projects",
              icon: "briefcase"
            }, {
              title: "New Project",
              link: "projects/new",
              icon: "plus"
            }
          ]
        }, {
          title: "Timesheets",
          link: "timesheets",
          icon: "time"
        }
      ];
      return $scope.admin_menu = [
        {
          title: "Settings",
          link: "admin/settings",
          icon: "settings"
        }, {
          title: "Reports",
          link: "admin/reports",
          icon: "dashboard"
        }
      ];
    }
  ]);

}).call(this);
