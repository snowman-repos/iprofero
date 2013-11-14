(function() {
  angular.module("iprofero.timesheets").constant("COUNTER", 1000).factory("Stopwatch", function(COUNTER, $timeout) {
    var data, reset, start, stop, stopwatch;
    data = {
      status: "off",
      value: 0
    };
    stopwatch = null;
    start = function() {
      data.status = "on";
      return stopwatch = $timeout(function() {
        data.value++;
        return start();
      }, COUNTER);
    };
    stop = function() {
      if (data.status === "paused") {
        return start();
      } else {
        data.status = "paused";
        $timeout.cancel(stopwatch);
        return stopwatch = null;
      }
    };
    reset = function() {
      data.status = "off";
      $timeout.cancel(stopwatch);
      stopwatch = null;
      return data.value = 0;
    };
    return {
      data: data,
      start: start,
      stop: stop,
      reset: reset
    };
  });

}).call(this);
