$document.on "ready", ()->
  $(".full-page-container .page-section").first().addClass("active")

scroll = (direction = "down")->
  $active_section = $(".full-page-container .page-section.active")


  if direction == "down"
    $next_section = $active_section.first().next()
  else
    $next_section = $active_section.first().prev()

  if direction == "up" && $active_section.length > 1
    $active_section.last().removeClass("active")
    $next_section = $active_section.first()



  if $next_section.length > 0
    if !$next_section.hasClass("fp-auto-height")
      $active_section.removeClass("active")
    $next_section.addClass("active")

  #if $next_section.hasClass("fp-auto-height")
  #  $next_section("")


$document.on "mousewheel", (e)->
  if $(".full-page-container").length == 0
    return true
  e.preventDefault()


  delay("scroll",
    ()->

      #alert("test")
      down = e.deltaY < 0
      #console.log(e.deltaX, e.deltaY, e.deltaFactor);
      if down
        scroll("down")
      else
        scroll("up")

      console.log "down: ", down

    500
    true
    true
  )