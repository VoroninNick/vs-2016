$document.on "ready page:load", ->
  if is_small()
    $('.tags').on 'click', ()->
      event.preventDefault()
      $(this).siblings().removeClass('opened')
      $(this).toggleClass('opened')