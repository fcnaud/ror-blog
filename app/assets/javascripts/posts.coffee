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

  $('.fa-trash').click (e) ->
    target = $(e.currentTarget)
    type = target.data("type")
    if type=="comment"
      res = confirm("delete comment?")
      if res
        postId = target.data("post_id")
        id = target.data("id")
        $.ajax
          url: "/posts/#{postId}/comments/#{id}"
          type: 'delete'
          success: (result) ->
            if result.state == 1
              $("#comment-#{id}").remove()
              comment_count = $("#comments-count b").text()
              $("#comments-count b").text(comment_count-1)
            else
              if result.data.url
                window.location.href = result.data.url

  $('#all-tags').on 'click', '.add-tag', (e) ->
  # 动态元素要将函数绑定到父级元素
  # $('.add-tag').click (e) ->
    fa = $(e.currentTarget)
    tagBox = fa.parent()
    tagId = tagBox.data('id')
    postId = tagBox.data('post_id')
    $.ajax
      url: "/posts/#{postId}/add_tag"
      type: 'get'
      data: 
        tag_id: tagId
      success: (res) ->
        $('#current-tags').append(tagBox)
        fa.removeClass('fa-check')
        fa.addClass('fa-close')
        fa.removeClass('add-tag')
        fa.addClass('delete-tag')

  $('#current-tags').on 'click', '.delete-tag', (e) ->
    fa = $(e.currentTarget)
    tagBox = fa.parent()
    tagId = tagBox.data('id')
    postId = tagBox.data('post_id')
    $.ajax
      url: "/posts/#{postId}/delete_tag"
      type: 'get'
      data:
        tag_id: tagId
      success: (res) ->
        $('#all-tags').append(tagBox)
        fa.removeClass('fa-close')
        fa.addClass('fa-check')
        fa.removeClass('delete-tag')
        fa.addClass('add-tag')






