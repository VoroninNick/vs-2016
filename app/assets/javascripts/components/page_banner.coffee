$document.on "ready page:load", ->
  #alert("rect")
  setTimeout(
    ->
      $rects = $('.rect:not(.disable-visible-class)')
      $rects.each ()->
        $rect = $(this)
        if !$rect.hasClass("visible")
          $rect.addClass("visible")

    200
  )

$document.on "click", ".page-banner .scroll-down", ()->
  $page_banner = $(this).closest(".page-banner")
  $("body").animate(scrollTop: $page_banner.height())

$document.on "mousewheel", (e)->
  $page_banner = $(".page-banner")
  page_banner_height = $page_banner.height()
  scroll_top = $window.scrollTop() || $("body").scrollTop() || $("html").scrollTop()
  window_height = window.innerHeight
  body_height = $("body").height()
  #console.log("#{e.type}: ", arguments)
  down = e.deltaY < 1


  if page_banner_height && scroll_top < page_banner_height && scroll_top + window_height < body_height && down
    e.preventDefault()
    #console.log "set page_banner_scroll_down"
    delay(
      "page_banner_scroll_down"
      ()->

        #console.log "call page_banner_scroll_down"
        $("body,html").animate({scrollTop: page_banner_height}, 800)
      800
      true
      false
    )
  else
    return true
