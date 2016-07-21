full_page_breakpoint = 1025

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
  if $(".full-page-container").length == 0 || window.innerWidth < full_page_breakpoint
    return true
  e.preventDefault()


  delay("scroll",
    ()->
      slider = $(".home-slider").data("bxSlider")
      slides_count = 3
      #alert("test")
      down = e.deltaY < 0
      #console.log(e.deltaX, e.deltaY, e.deltaFactor);

      console.log "e: ", e
      active_section_index = $(".page-section.active").index()
      if active_section_index == 1 && down && slider.getCurrentSlide() < slides_count - 1
        slider.goToNextSlide()
      else if down
        scroll("down")
      else
        scroll("up")

      console.log "down: ", down

    500
    true
    false
  )