$(".about-bxslider").bxSlider({
  auto: true
  pager: false
  controls: true
  prevSelector: ".custom-controls .prev"
  nextSelector: ".custom-controls .next"
  onSlideBefore: ($slideElement, oldIndex, newIndex)->
    $controls = $(this).closest(".slider").find(".custom-controls")
    $controls.find(".current-number").text(newIndex + 1)
})