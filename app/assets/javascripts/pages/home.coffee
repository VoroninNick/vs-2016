$('document').ready ()->
  options = { videoId: 'a69zhkp3TkI', start: 3 };
  $('#welcome-page-section').tubular(options);
  # f-UGhWj1xww cool sepia hd
  # 49SKbS7Xwf4 beautiful barn sepia
  # cdrHWbBQ-Nc Oil Pump
  # rnQ7nayIcLo sun sparcles over the river




$(".full-page-container").fullpage({

  onLeave: (index, next_index, direction)->
    console.log("index: ", index, "next_index: ", next_index, "direction: ", direction)
    if index == 2
      $section = $("#home-portfolio-section")
      $slides = $section.find('.slide')
      current_step_index = $slides.filter(".active").index()

      if direction == 'down'
        max_step_index = $slides.length - 1
        console.log "current_step_index: ", current_step_index, "max_step_index: ", max_step_index
        if current_step_index < max_step_index
          $.fn.fullpage.moveSlideRight();

          return false

      else if direction == 'up'
        min_step_index = 0
        if current_step_index > min_step_index
          $.fn.fullpage.moveSlideLeft();
          return false


    return true
})