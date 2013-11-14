(function() {
  angular.module("iprofero.timesheets").constant("prefix", "prefs-").factory("TimesheetPreferences", function(prefix) {
    var clearPrefs, get, getKeys, remove, set;
    set = function(key, value) {
      if (angular.isObject(value) || angular.isArray(value)) {
        value = angular.toJson(value);
      }
      return localStorage.setItem(prefix + key, value);
    };
    get = function(key) {
      var item;
      item = localStorage.getItem(prefix + key);
      if (!item || item === "null") {
        return "";
      }
      if (item.charAt(0) === "{" || item.charAt(0) === "[") {
        return angular.fromJson(item);
      }
      return item;
    };
    remove = function(key) {
      return localStorage.removeItem(prefix + key);
    };
    getKeys = function() {
      var key, keys, prefixLength;
      prefixLength = prefix.length;
      keys = [];
      for (key in localStorage) {
        if (key.substr(0, prefixLength) === prefix) {
          keys.push(key.substr(prefixLength));
        }
      }
      return keys;
    };
    clearPrefs = function() {
      var key, prefixLength;
      prefixLength = prefix.length;
      for (key in localStorage) {
        if (key.substr(0, prefixLength) === prefix) {
          removeFromLocalStorage(key.substr(prefixLength));
        }
      }
      return true;
    };
    return {
      set: set,
      get: get,
      remove: remove,
      getKeys: getKeys,
      clearPrefs: clearPrefs
    };
  });

}).call(this);
