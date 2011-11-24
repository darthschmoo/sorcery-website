# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

/* Hello */

summ = (nums...) ->
  result = 0
  nums.forEach(n) -> result += n
  result
 