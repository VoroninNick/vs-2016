$document.on "ready page:load", ->  
  
  $image_container = $('.image-container')
  $image_container.find('.image-svg').appear()
  $image_container.on "appear", ".image-svg", ()->
    $(this).addClass("visible")

  $blockquote_container = $('.article-blockquote')
  $blockquote_container.find('.top-border, .bottom-border, .left-border, .right-border').appear()
  $blockquote_container.on "appear", ()->
    $(this).addClass("visible")
  $blockquote_container.on "appear", ".top-border, .bottom-border", ()->
    $(this).addClass("visible")
  $blockquote_container.on "appear", ".left-border, .right-border", ()->
    $(this).addClass("visible")

  $principles = $(".principles")
  $principles.find('.principle').appear()
  $principles.on "appear", ".principle", ()->
    $(this).addClass("visible")

  # $team = $(".team-member-blocks")
  # $team.find('.team-member-block').appear()
  # $team.on "appear", ".team-member-block", ()->
  #   $(this).addClass("visible")

  $team = $(".team-member-blocks")
  $team.appear()
  $team.on "appear", ()->
    $team.find(".team-member-block, .join-us-block").each (index)->
      $project = $(this)
      # transition_delay_str = "#{1000 + index * 100}ms"
      
      setTimeout(
        ()->
          $project.addClass("visible")
        index * 300
      )











  $(".about-bxslider").bxSlider({
    auto: true
    pager: false
    controls: true
    prevSelector: ".custom-controls .prev"
    nextSelector: ".custom-controls .next"
    prevText: ""
    nextText: ""
    onSlideBefore: ($slideElement, oldIndex, newIndex)->
      $controls = $(this).closest(".slider").find(".custom-controls")
      $controls.find(".current-number").text(newIndex + 1)
  })


