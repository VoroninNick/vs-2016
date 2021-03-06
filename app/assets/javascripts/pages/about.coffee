scroll_container = (scroll_direction)->
  $this = $(this)
  current_scroll_left = $this.scrollLeft()
  step = 200
  step = 50

  if scroll_direction == "left"
    new_scroll_left = current_scroll_left - step
  else
    new_scroll_left = current_scroll_left + step

  #console.log "swipe: scroll_direction: ", scroll_direction
  console.log "new_scroll_left: ", new_scroll_left
  $this.scrollLeft(new_scroll_left)

$document.on "click", "[controller-action='pages__about_us'] .page-banner", ()->
  $("body").addClass("has-opened-video-popup")
  about_play()

$document.on "click", "#about-video-popup-close-button", ()->
  $("body").removeClass("has-opened-video-popup")
  about_stop()

$document.on "ready page:load", ->
  
  $image_container = $('.image-container')
  $image_svg = $image_container.find('.image-svg')
  $image_svg.appear()
  $image_svg.filter(":appeared").trigger("appear")


  $blockquote_container = $('.article-blockquote')
  $blockquote_container.appear()
  $blockquote_container.filter(":appeared").trigger("appear")


#  $blockquote_container.on "appear", ".top-border, .bottom-border", ()->
#    $(this).addClass("visible")
#  $blockquote_container.on "appear", ".left-border, .right-border", ()->
#    $(this).addClass("visible")

  $principles = $(".principles")
  $principle_items = $principles.find('.principle')
  $principle_items.appear()
  $principle_items.filter(":appeared").trigger("appear")



  $team = $(".team-member-blocks")
  $team.appear()
  $team.filter(":appeared").trigger("appear")


  $about_bx_slider = $(".about-bxslider")
  $about_bx_slider.find(".slides").bxSlider({
    auto: true
    pager: false
    controls: true
    mode: 'fade'
    speed: 1000
    pause: 8000
    prevSelector: $about_bx_slider.find(".custom-controls .prev")
    nextSelector: $about_bx_slider.find(".custom-controls .next")
    prevText: ""
    nextText: ""
    onSlideBefore: ($slideElement, oldIndex, newIndex)->
      $controls = $(this).closest(".slider").find(".custom-controls")
      $controls.find(".current-number").text(newIndex + 1)
  })

  $(".horizontal-container").swipe(
    swipeStatus: (event, phase, direction, distance, duration, finger_count, finger_data, current_direction)->
      window.mouse_down = true

      if phase != "move"
        return

      #console.log "swipe: this: ", this, "; args: ", arguments

      scroll_direction = if direction == "left" then "right" else if direction == "right" then "left" else false

      if !scroll_direction
        return

      $container = $(this)

      delay("scroll_container"
        ()->
          if window.mouse_down != false
            scroll_container.call($container, scroll_direction)
        50
        true
        false
      )


  )

$.clickOut(
  ".horizontal-container"
  ()->
    window.mouse_down = false
)


$document.on "appear", ".team-member-blocks", ()->
  $team = $(this)
  $team.find(".team-member-block, .join-us-block").each (index)->
    $project = $(this)

    setTimeout(
      ()->
        $project.addClass("visible")
      index * 300
    )

$document.on "appear", ".image-container .image-svg, .article-blockquote", ()->
  $(this).addClass("visible")

$document.on "appear", ".principles .principle", ()->
  $(this).addClass("visible")
  $(this).find('.line').addClass('animate')