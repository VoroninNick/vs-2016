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