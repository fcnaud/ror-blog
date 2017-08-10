# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.button-follow-user').click (e) ->
    btn = $(e.currentTarget)
    userId = btn.data("id")
    span = btn.find("span")
    if btn.hasClass("active")
      $.ajax
        url: "/users/#{userId}/unfollow"
        type: "post"
        success: (res) ->
          btn.removeClass("active")
          span.text("follow")
    else
      $.ajax
        url: "/users/#{userId}/follow"
        type: "post"
        success: (res) ->
          btn.addClass("active")
          span.text("unfollow")
    return false

