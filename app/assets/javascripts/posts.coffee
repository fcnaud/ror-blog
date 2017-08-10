# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.preview').click (e) ->
    $('#page_body').hide()
    $('#preview').show()
    $.ajax
      url: '/markdown'
      type: 'post'
      data:
        body: $('#page_body').val()
      success: (res) ->
        $('#preview div').html(res.md2html)


  $('.edit').click (e) ->
    $('#page_body').show()
    $('#preview').hide()
