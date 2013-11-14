(function() {
  var getHoursMinutesSeconds;

  getHoursMinutesSeconds = function(time) {
    var hours, leadingZero, minutes, seconds;
    minutes = Math.floor(time / 60);
    hours = Math.floor(minutes / 60);
    minutes = minutes - (hours * 60);
    seconds = time - (hours * 60 * 60) - (minutes * 60);
    leadingZero = function(n) {
      if (n < 10) {
        return "0" + n;
      } else {
        return n;
      }
    };
    return [leadingZero(hours), leadingZero(minutes), leadingZero(seconds)];
  };

  angular.module("iprofero.timesheets").filter("time", function() {
    return function(input) {
      var time;
      if (input) {
        time = getHoursMinutesSeconds(input);
        return time[0] + "h " + time[1] + "m " + time[2] + "s";
      } else {
        return "0h 0m 0s";
      }
    };
  });

  angular.module("iprofero.timesheets").filter("duration", function() {
    return function(input) {
      var time;
      if (input) {
        time = getHoursMinutesSeconds(input);
        return time[0] + ":" + time[1] + ":" + time[2];
      } else {
        return "00:00:00";
      }
    };
  });

}).call(this);
