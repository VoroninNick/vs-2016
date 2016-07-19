$(".project-bxslider").each ()->
  $wrap = $(this)
  $slider = $wrap.find("> ul")
  $pager = $wrap.find(".custom-pager")
  $slider.bxSlider({
    auto: true
    pager: true
    pagerCustom: $pager
    controls: true
    #prevSelector: ".custom-controls .prev"
    #nextSelector: ".custom-controls .next"
    onSlideBefore: ($slideElement, oldIndex, newIndex)->
      #$controls = $(this).closest(".slider").find(".custom-controls")
      #$controls.find(".current-number").text(newIndex + 1)
      $pager.find(".page").eq(oldIndex).removeClass("active")
      $pager.find(".page").eq(newIndex).addClass("active")
  })


$(".desktop-slider").each (index)->
  $wrap = $(this)
  $slider = $(".screen-images-bxslider")
  $pager = $wrap.find(".custom-pager")
  $slider.bxSlider({
    mode: "fade"
    auto: true
    pager: true
    pagerCustom: $pager
    prevSelector: ".desktop-slider:eq(#{index}) .custom-controls .prev"
    nextSelector: ".desktop-slider:eq(#{index}) .custom-controls .next"
    #adaptiveHeight: true
    controls: true
    onSlideBefore: ($slideElement, oldIndex, newIndex)->
      $pager.find(".page").eq(oldIndex).removeClass("active")
      $pager.find(".page").eq(newIndex).addClass("active")
  })

animate_header = ()->

  $element = $(this)
  $element.addClass("visible")
  if !$element.hasClass("textillated")
    $element.addClass("textillated")
    $element.textillate({
      in: {
        effect: "fadeIn"
        delay: 50
      }
    })
  else
    $element.textillate("start")

show_headers = ()->
  scroll_top = $window.scrollTop()
  screen_bottom = scroll_top + window.innerHeight
  elements = [[".project-content .project-large-section-title:not(.visible)", 0], [".project-content .fade-in:not(.visible)", -300],
    [".project-section .section-descriptive-title:not(.visible)", 0, animate_header], "" ]
  for element in elements
    $headers = $(element[0])
    $headers.each ()->
      $header = $(this)
      header_offset = $header.offset()
      console.log "header_offset: ", header_offset

      header_top = header_offset && header_offset.top || false
      handler = element[2] || false
      if header_top != false
        modifier = element[1] || 0
        if header_top <= screen_bottom + modifier
          if handler
            handler.call($header)
          else
            $header.addClass("visible")


$window.on "scroll", show_headers

show_headers()
