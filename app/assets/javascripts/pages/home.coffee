
$document.on "ready page:load", ->

  $welcome_page_section = $('#welcome-page-section')

  ###
  # init home video tubular
  if $welcome_page_section.attr("tubular") == 'true'
    options = { videoId: $welcome_page_section.attr("tubular-video-id"), start: 3 }
    $welcome_page_section.tubular(options);
  ###

  # f-UGhWj1xww cool sepia hd
  # 49SKbS7Xwf4 beautiful barn sepia
  # cdrHWbBQ-Nc Oil Pump
  # rnQ7nayIcLo sun sparcles over the river


  $welcome_page_section.find(".white-header").textillate({
    in: {
      effect: "fadeIn"
      delay: 35 # 35
    }
  })

###
$document.on "mouseenter", "#home-services-section .service", (e)->
  console.log e.type
  $service = $(this)
  $service_description = $service.find(".service-description")
  if !$service_description.hasClass("textillated")
    $service_description.addClass("textillated")
    $service_description.textillate({
      in: {
        effect: "fadeIn"
        delay: 10
      }

    })
  else
    $service_description.textillate("start")
###



#$(".full-page-container").fullpage({
#
#  onLeave: (index, next_index, direction)->
#    console.log("index: ", index, "next_index: ", next_index, "direction: ", direction)
#    if index == 2
#      $section = $("#home-portfolio-section")
#      $slides = $section.find('.slide')
#      current_step_index = $slides.filter(".active").index()
#
#      if direction == 'down'
#        max_step_index = $slides.length - 1
#        console.log "current_step_index: ", current_step_index, "max_step_index: ", max_step_index
#        if current_step_index < max_step_index
#          $.fn.fullpage.moveSlideRight();
#
#          return false
#
#      else if direction == 'up'
#        min_step_index = 0
#        if current_step_index > min_step_index
#          $.fn.fullpage.moveSlideLeft();
#          return false
#
#
#    return true
#})


#$(".home-slider").bxSlider(
#  #auto: true
#)

$document.on "click", "#welcome-block .play-link", ()->
  $("body").addClass("has-opened-video-popup")
  home_full_play()


$document.on "click", "#home-full-video-popup-close-button", ()->
  $("body").removeClass("has-opened-video-popup")
  home_full_stop()