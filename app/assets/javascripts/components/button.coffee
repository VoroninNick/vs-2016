$document.on "mouseenter mouseout", ".btn *, .icon-btn:not(.allow-propagation) *", (e)->
  e.stopImmediatePropagation()

$document.on "mouseenter", ".btn, .icon-btn, #welcome-scroll-down", (e)->
  e.stopPropagation()
  #alert(e.type)
  $button = $(this)
  #$button.removeClass('out').addClass('over')
  current_time = Date.now()
  last_time = $button.data("last_mouse_in")
  console.log "#{e.type}", (if last_time then current_time - last_time else 0), "e.target: ", e.target, "; event: ", e

  $button.data("last_mouse_in", current_time)
  delay("button_mouse",
    ()->
      $button.changeClasses('over', 'out')  # removeClass('out').addClass('over')
    800
    true
  )



$document.on "mouseleave", ".btn, .icon-btn, #welcome-scroll-down", (e)->
  e.stopPropagation()
  $button = $(this)

  last_time = $button.data("last_mouse_in")
  current_time = Date.now()

  $button.data("last_mouse_in", null)

  if last_time
    time_diff = current_time - last_time

    if time_diff >= 300
      delay("button_mouse"
        ()->
          $button.changeClasses('out', 'over')
        800
        true
      )
