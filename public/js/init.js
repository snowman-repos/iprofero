(function() {
  window.bootstrap = function() {
    return angular.bootstrap(document, ["iprofero"]);
  };

  window.init = function() {
    return window.bootstrap();
  };

  $(document).ready(function() {
    if (window.location.hash === "#_=_") {
      window.location.hash = "!";
    }
    return window.init();
  });

}).call(this);
