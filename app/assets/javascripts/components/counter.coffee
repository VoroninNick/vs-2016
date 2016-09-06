$document.on "ready page:load", ->

  setTimeout (->
    $('.number').addClass('visible')
    $('.counter').counterUp(
      time: 500
    )
  ), 200