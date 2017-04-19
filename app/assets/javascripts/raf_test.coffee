use_raf = true
#console.log("hello")

if !use_raf
  console.log "don't use raf"
  lookAtScroll = ->
    console.log("window.pageYOffset: ", window.pageYOffset); # Return the Y scroll position

  window.addEventListener('scroll', lookAtScroll);



#The problem with this solution is when the user scrolls too fast. The method
# doesn't run fast enough to give you the accurate final Y position.

if use_raf
  console.log("use raf")

  lookAtScroll = ->
    #console.log("window.pageYOffset: ", window.pageYOffset); # Return the Y scroll position 60 times per second

    # The idea here is to call `requestAnimationFrame` again to run the function again.
    # It's like a `setTimeout` running the same function 60 times per second.
    # Since rAF runs at 60FPS even if you user scrolls really fast the final value for
    # the Y position will be accurate.
    window.requestAnimationFrame(lookAtScroll);

  window.requestAnimationFrame(lookAtScroll); # Will run the method at least once