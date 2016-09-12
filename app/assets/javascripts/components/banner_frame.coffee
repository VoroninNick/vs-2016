$document.on "ready page:load", ->  

  $frame = $('.rect')

  $frame.append('<div class="left-border"></div>')
  $frame.append('<div class="right-border"></div>')
  $frame.append('<div class="top-border"></div>')
  $frame.append('<div class="bottom-border"></div>')

  $border = $frame.find('.top-border, .bottom-border, .left-border, .right-border')

  setTimeout (->
    if !$border.hasClass("visible")
      $border.addClass("visible")
  ), 200