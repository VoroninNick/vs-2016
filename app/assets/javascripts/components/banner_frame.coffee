$document.on "ready page:load", ->  

  $rect = $('.rect')

  #$border = $frame.find('.top-border, .bottom-border, .left-border, .right-border')



  setTimeout (->
    if !$rect.hasClass("visible")
      $rect.addClass("visible")
  ), 200