$document.on "ready page:load", ->

  $rect = $('.rect')

  setTimeout (->
    if !$rect.hasClass("visible") && !$rect.hasClass("disable-visible-class")
      $rect.addClass("visible")
  ), 200

$document.on "click", ".page-banner .scroll-down", ()->
  $page_banner = $(this).closest(".page-banner")
  $("body").animate(scrollTop: $page_banner.height())

$document.on "mousewheel", (e)->
  $page_banner = $(".page-banner")
  page_banner_height = $page_banner.height()
  scroll_top = $("body").scrollTop()
  window_height = window.innerHeight
  body_height = $("body").height()
  console.log("#{e.type}: ", arguments)
  down = e.deltaY < 1


  if page_banner_height && scroll_top < page_banner_height && scroll_top + window_height < body_height && down
    e.preventDefault()
    delay(
      "page_banner_scroll_down"
      ()->
        console.log "scroll"
        $("body").animate({scrollTop: page_banner_height}, 800)
      1000
      true
      false
    )

