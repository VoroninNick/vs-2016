full_page_breakpoint = 1025
full_page_breakpoint = 0

large_breakpoint = 1025



$document.on "ready page:load", ->
  $("body").attr("data-full-page-section", 0)
  $(".full-page-container .page-section").first().addClass("active")

scroll = (direction = "down")->
  $active_section = $(".full-page-container .page-section.active")
  active_section_index = $active_section.index()


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

  next_section_index = $next_section.index()
  $("body").attr("data-full-page-section", next_section_index)

  if next_section_index == 1 && direction == "up" && window.innerWidth < large_breakpoint
    $window.scrollTop(0)

  #if $next_section.hasClass("fp-auto-height")
  #  $next_section("")

setHomeSliderNavigationListItem = (index = 0)->
  $home_slider_navigation_items = $(".home-slider-navigation .navigation-list-item")
  $home_slider_navigation_items.filter(".active").removeClass("active")
  $home_slider_navigation_items.filter("[data-slide-index='#{index}']").addClass("active")

setSlide = (index = 0)->
  slide = $home_slider.find(".home-portfolio-slide").removeClass('visible').eq(index)
  slide_key = slide.attr("data-banner-key")

  $home_slider.attr("active-slide", slide_key)
  $("body").attr("home-active-slide", slide_key)
  slide.addClass('visible')
  setHomeSliderNavigationListItem(index)
  window.currentIndex = index

slideSlides = (direction = "next")->
  slides.removeClass('visible')
  $slide = $home_slider.find(".home-portfolio-slide").eq(currentIndex)
  slide_key = $slide.attr("data-banner-key")
  $home_slider.attr("active-slide", slide_key)
  $("body").attr("home-active-slide", slide_key)
  $slide.addClass('visible')
  slide_index = $slide.index()
  setHomeSliderNavigationListItem(slide_index)



init = ()->
  window.$home_slider = $('.slider-container')

  window.currentIndex = 0
  window.slides = $home_slider.find('.home-portfolio-slide')
  window.slidesQnt = slides.length

  window.wing = $('.slider .wing')
  window.sliderbg = $('.slider .slider-bg')

init()

$document.on "page:load", init
  
  
$(".page-section").on "move", (e)->
  #console.log "#{e.type}: ", arguments

scroll_handler = (e, direction)->
  console.log "#{e.type}: "
  if $(".full-page-container").length == 0 || (full_page_breakpoint || window.innerWidth < full_page_breakpoint)
    return true

  handler_this = this
  handler_args = arguments


  down = e.deltaY < 0 || direction == "up"
  $active_section = $(".page-section.active")
  active_section_index = $active_section.index()
  active_section_one_screen = $active_section.hasClass("small-one-screen")
  scroll_top = $window.scrollTop()
  prevent_default_scroll = window.innerWidth >= large_breakpoint || (down && active_section_one_screen) || (!down && active_section_index > 0 && !(active_section_index == 2 && scroll_top > 0 ))
  #console.log "prevent_default_scroll: ", prevent_default_scroll
  if prevent_default_scroll
    e.preventDefault()
    defaultPrevented = true
  else
    defaultPrevented = false


  #if window.innerWidth < large_breakpoint && active_section_index == 2 && down
  #  return true

  delay("scroll",
    ()->

      scroll_top = $window.scrollTop()
      #console.log(e.deltaX, e.deltaY, e.deltaFactor);

      #console.log "e: ", e

      # if !(active_section_index == 0 && down)
      #   slides.removeClass('visible')

      if active_section_index == 0 && down
        setSlide()

      not_last_slide = currentIndex < slidesQnt - 1
      console.log "hello"
      if active_section_index == 1 && down
        if not_last_slide
          currentIndex += 1
          slideSlides()
          defaultPrevented = true
        else if down
          scroll("down")
        else
          scroll("up")
      else if down
        if window.innerWidth >= large_breakpoint || (active_section_index <= 0)
          scroll("down")
      else
        current_slide_index = $(".home-portfolio-slide.visible").index()
        if active_section_index == 1 && current_slide_index > 0 && !down
          slide_index = current_slide_index - 1
          setSlide(slide_index)
        else if active_section_index == 1 && current_slide_index == 0 && !down
          scroll("up")
          if window.innerWidth < large_breakpoint
            defaultPrevented = true

        else if window.innerWidth >= large_breakpoint
          scroll("up")
        else if currentIndex == 2 && scroll_top == 0
          scroll("up")
          defaultPrevented = true
        #else if currentIndex == 1 && !down




      if active_section_index == 2 && !down
        setSlide(2)

      if defaultPrevented
        e.preventDefault()

      e.defaultPrevented = defaultPrevented
      $(this).data({ "allowPageScroll": false })
      allowPageScroll = if !defaultPrevented then "vertical" else false
      $("body").swipe('option', 'allowPageScroll', allowPageScroll)



      #console.log "down: ", down
      console.debug "this: ", handler_this, "; arguments: ", handler_args
      console.debug "active_section_index: ", active_section_index, "; not_last_slide: ", not_last_slide, "; down: ", down, "; scroll_top: ", scroll_top, "; currentIndex: ", currentIndex
      console.debug "defaultPrevented: ", defaultPrevented
    500
    true
    false
  )

$document.on "mousewheel", scroll_handler



$document.on "ready", ()->
  $body = $("body")
  if !$body.hasClass("initialized-swipe")
    $body.addClass("initialized-swipe")
    $body.swipe(
      swipe: scroll_handler
    )


$document.on "click", ".home-slider-navigation .navigation-list-item:not(.active)", ()->
  index = $(this).attr("data-slide-index")
  setSlide(index)


$document.on "click", "#welcome-page-section .scroll-down", ()->
  setSlide()
  scroll("down")