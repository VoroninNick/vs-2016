#full_page_breakpoint = 1440
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
    if !$next_section.hasClass("fp-auto-height") || $next_section.hasClass("fp-min-screen-height")
      $active_section.removeClass("active")
    $next_section.addClass("active")

  next_section_index = $next_section.index()
  $("body").attr("data-full-page-section", next_section_index)

  if next_section_index == 1 && direction == "up" && window.innerWidth < large_breakpoint
    $window.scrollTop(0)

  console.log "next_section_index: ", next_section_index, "; direction: ", direction

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
  #console.log "#{e.type}: ", argumentsx

window.check_if_default_scroll_swipe = ()->
  $body = $("body")
  scroll_locked = $body.hasClass("has-opened-projects-popup") || $body.hasClass("has-opened-menu") || $body.hasClass("has-opened-hire-us-form-popup") || $body.hasClass("has-opened-join-us-form-popup")
  scroll_locked || $(".full-page-container").length == 0 || (full_page_breakpoint && window.innerWidth < full_page_breakpoint)


scroll_handler = (e, direction)->
  if check_if_default_scroll_swipe()
    console.log "scroll_handler: return true"
    return true

  $body = $("body")

  handler_this = this
  handler_args = arguments


  down = e.deltaY < 0 || direction == "up"
  up = !down
  $active_section = $(".page-section.active")
  active_section_index = $active_section.index()
  active_section_one_screen = $active_section.hasClass("small-one-screen")
  max_scroll_top = null
  scroll_top = $window.scrollTop() || $("body").scrollTop() || $("html").scrollTop()
  $home_footer = $("#home-footer")

  if !scroll_top
    scroll_top = $active_section.find(".section-container").scrollTop()
    if scroll_top
      max_scroll_top = $active_section.find(".section-content").height() - window.innerHeight

  bottom_achieved = max_scroll_top && scroll_top == max_scroll_top
  footer_was_active = null
  if up && $home_footer.hasClass("active")
    footer_was_active = true
    $home_footer.removeClass("active")
    e.preventDefault() if e && e.preventDefault
    return false

  if active_section_index == 2 && !(up && !scroll_top) && !(down && bottom_achieved)
    container_height = $active_section.find(".section-container").height()
    content_height = $active_section.find(".section-content").height()
    if content_height > container_height
      $("body").swipe('option', 'allowPageScroll', "vertical")
      return true
  console.log "bottom_achieved: ", bottom_achieved
  if active_section_index == 2 && down && bottom_achieved
    $("#home-footer").addClass("active")
    e.preventDefault() if e && e.preventDefault
    return false



  prevent_default_scroll = window.innerWidth >= large_breakpoint || (down && active_section_one_screen) || (up && active_section_index > 0 && !(active_section_index == 2 && scroll_top > 0 )) && active_section_index
  console.log "prevent_default_scroll: ", prevent_default_scroll

  if window.innerWidth <= 640
    if down && $("#home-footer:appeared").length
      $("body, html").animate(scrollTop: $("#home-footer").offset().top)
      e.preventDefault()
      return false

  if prevent_default_scroll
    e.preventDefault()
    defaultPrevented = true
  else
    defaultPrevented = false




  #if window.innerWidth < large_breakpoint && active_section_index == 2 && down
  #  return true

  delay("scroll",
    ()->

      if up && ($home_footer.hasClass("active") || footer_was_active)
        $home_footer.removeClass("active")
        e.preventDefault() if e && e.preventDefault
        return false

      scroll_top = $window.scrollTop()
      #console.log(e.deltaX, e.deltaY, e.deltaFactor);

      #console.log "e: ", e

      # if !(active_section_index == 0 && down)
      #   slides.removeClass('visible')

      if active_section_index == 0 && down
        setSlide()

      not_last_slide = currentIndex < slidesQnt - 1
      console.log "hello"

      if active_section_index == 2 && !(up && !scroll_top) && !(down && bottom_achieved)
        container_height = $active_section.find(".section-container").height()
        content_height = $active_section.find(".section-content").height()

        if content_height > container_height
          $("body").swipe('option', 'allowPageScroll', "vertical")
          return true
      console.log "MY_TEST"
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
        if active_section_index == 1 && current_slide_index > 0 && up
          slide_index = current_slide_index - 1
          setSlide(slide_index)
        else if active_section_index == 1 && current_slide_index == 0 && up
          scroll("up")
          if window.innerWidth < large_breakpoint
            defaultPrevented = true

        else if window.innerWidth >= large_breakpoint
          scroll("up")
        else if currentIndex == 2 && scroll_top == 0
          scroll("up")
          defaultPrevented = true
        #else if currentIndex == 1 && !down




      if active_section_index == 2 && up
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



$document.on "ready page:load", ()->
  $body = $("body")
  if !$body.hasClass("initialized-swipe") && !check_if_default_scroll_swipe()
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