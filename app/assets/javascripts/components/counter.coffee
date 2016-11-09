$document.on "ready page:load", ->
  setTimeout (->
    $('.number').addClass('visible')
    $('.counter').counterUp(
      time: 500
    )
  ), 2500
  setTimeout (->
    $('.number-with-subtitle .subtitle').addClass('visible')
  ), 3000