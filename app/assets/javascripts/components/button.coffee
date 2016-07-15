$document.on "mouseover", ".btn", ()->
  $button = $(this)
  #$button.removeClass('out').addClass('over')
  delay( "button_mouse",
    ()->
      $button.removeClass('out').addClass('over')
    800
    true
  )



$document.on "mouseout", ".btn", ()->
  $button = $(this)
  #$button.removeClass('over').addClass('out')

  delay("button_mouse"
    ()->
      $button.removeClass('over').addClass('out')
    800
    true
  )

