# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
#
jQuery ->
  $('#diag').submit (e) ->
    e.preventDefault()
    uid = $('#name').val()
    uid.replace(/^\s*(.*?)\s*$/, "$1")
    location.href = '/diag/' + uid
    false
