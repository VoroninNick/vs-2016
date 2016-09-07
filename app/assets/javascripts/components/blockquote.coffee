$document.on "ready page:load", ->  

  $blockquote_container = $('.article-content, .service-content')

  $blockquote = $blockquote_container.find('blockquote')
  $blockquote.append('<div class="blockquote-border"></div>')

  $border = $blockquote.find('.blockquote-border')

  $border.append('<div class="left-border"></div>')
  $border.append('<div class="right-border"></div>')
  $border.append('<div class="top-border"></div>')
  $border.append('<div class="bottom-border"></div>')

  $blockquote_container.find('.top-border, .bottom-border, .left-border, .right-border').appear()
  $blockquote_container.on "appear", "blockquote", ()->
    $(this).addClass("visible")
  $blockquote_container.on "appear", ".top-border, .bottom-border", ()->
    $(this).addClass("visible")
  $blockquote_container.on "appear", ".left-border, .right-border", ()->
    $(this).addClass("visible")