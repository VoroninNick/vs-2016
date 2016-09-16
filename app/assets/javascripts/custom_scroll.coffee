full_page_breakpoint = 1025



$document.on "ready page:load", ->
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



setSlide = (index = 0)->
  slide = $home_slider.find(".home-portfolio-slide").removeClass('visible').eq(index)
  slide_key = slide.attr("data-banner-key")
  $home_slider.attr("active-slide", slide_key)  
  slide.addClass('visible')
  window.currentIndex = index

slideSlides = ->
  slides.removeClass('visible')
  slide = $home_slider.find(".home-portfolio-slide").eq(currentIndex)
  slide_key = slide.attr("data-banner-key")
  $home_slider.attr("active-slide", slide_key)
  slide.addClass('visible')

init = ()->
  window.$home_slider = $('.slider-container')

  window.currentIndex = 0
  window.slides = $home_slider.find('.home-portfolio-slide')
  window.slidesQnt = slides.length

  window.wing = $('.slider .wing')
  window.sliderbg = $('.slider .slider-bg')

init()

$document.on "page:load", init
  
  


$document.on "mousewheel swipe swipedown", (e)->
  if $(".full-page-container").length == 0 || window.innerWidth < full_page_breakpoint
    return true
  e.preventDefault()


  delay("scroll",
    ()->
      down = e.deltaY < 0
      #console.log(e.deltaX, e.deltaY, e.deltaFactor);

      console.log "e: ", e
      active_section_index = $(".page-section.active").index()
      # if !(active_section_index == 0 && down)
      #   slides.removeClass('visible')

      if active_section_index == 0 && down
        setSlide()

      if active_section_index == 1 && down
        if currentIndex < slidesQnt - 1
          currentIndex += 1
          slideSlides()
        else if down
          scroll("down")
        else
          scroll("up")    
      else if down
        scroll("down")
      else
        scroll("up")

      if active_section_index == 2 && !down
        setSlide(2)

      console.log "down: ", down

    500
    true
    false
  )