$document.on "mouseover", ".btn", ()->
  $(this).removeClass('out').addClass('over')

$document.on "mouseout", ".btn", ()->
  $(this).removeClass('over').addClass('out')
