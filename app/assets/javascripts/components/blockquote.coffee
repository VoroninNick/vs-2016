$("body").on "appear", ".article-content blockquote:not(.visible), .service-content blockquote:not(.visible)", ()->
  $blockquote = $(this)
  $blockquote.addClass("visible")
  setTimeout(
    ()->
      $blockquote.find(".top-border, .bottom-border, .left-border, .right-border").addClass("visible")
    10
  )


$document.on "ready page:load", ->

  $article_content = $('.article-content, .service-content')

  $blockquote = $article_content.find('blockquote')
  $blockquote.append('<div class="blockquote-border"></div>')

  $border = $blockquote.find('.blockquote-border')

  border_str = ''
  border_str += '<div class="left-border"></div>'
  border_str += '<div class="right-border"></div>'
  border_str += '<div class="top-border"></div>'
  border_str += '<div class="bottom-border"></div>'
  $border.html(border_str)

  $border_lines = $blockquote.find(".top-border, .bottom-border, .left-border, .right-border")
  $blockquote.appear()




  $border_lines.filter()

  $blockquote.trigger("appear")

