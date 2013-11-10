# main bootstrapping file

window.bootstrap = ->
	angular.bootstrap document, [ "iprofero" ]

window.init = ->
	window.bootstrap()

# ensure the hashbang is always used
$(document).ready ->
	window.location.hash = "!"  if window.location.hash is "#_=_"
	window.init()