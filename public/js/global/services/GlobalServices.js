(function() {
  var underscore;

  angular.module("iprofero.system").factory("Global", [
    function() {
      return this._data = {
        user: window.user,
        authenticated: !!window.user
      };
    }
  ]);

  underscore = angular.module("underscore", []);

  underscore.factory("_", function() {
    return window._;
  });

}).call(this);
