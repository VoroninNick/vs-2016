handle_scroll = (e)->
  $banner = $(".page-banner")
  banner_height = $banner.height()

  scroll_top = $("body").scrollTop() || $(window).scrollTop()
  $top_nav = $(".top-nav")
  top_nav_height = $top_nav.height()

  if e && e.scrollTopDelta
    delta = e.scrollTopDelta
  else
    delta = e

  # top banner

  $banner_title = $(".page-banner-description-block:not(.disable-scroll)")
  if $banner_title.length
    ratio = 0.65
    #current_translate = $banner_title.data("translateY") || 0
    current_translate = "UNUSED"
    #future_translate = current_translate + delta * ratio
    base_translate_percent = -50
    future_translate = base_translate_percent + ratio * scroll_top
    opacity_ratio = 0.1
    opacity = 1 - (scroll_top * opacity_ratio / 100)
    #$banner_title.data("translateY", future_translate)

    #transform_value = "translateX(-50%) translateY(#{future_translate}px)"
    transform_value = "translateX(-50%) translateY(#{future_translate}%)"

    console.log "FIXED_PAGE_BANNER: handle_scroll: current_translate: ", current_translate, "; future_translate: ", future_translate, "; delta: ", delta

    $banner_title.css({"transform": transform_value, opacity: opacity})


$window.on "scrolldelta", handle_scroll

handle_scroll(0)