popup_in_duration = 2000
popup_in_duration = 500

$document.on "click", "#projects-popup-button", ()->
  $projects_popup = $(".projects-popup")


  $projects_popup.addClass("show")
  $projects_popup.addClass("animate-open")
  opened = open_menu("projects-popup")
  setTimeout(
    ()->
      $projects_popup.addClass("ready")
    popup_in_duration
  )


  # fadein projects
  $projects_popup.find(".project, .more-projects-soon").each (index)->
    $project = $(this)
    transition_delay_str = "#{1000 + index * 100}ms"

    setTimeout(
      ()->
        $project.addClass("show")
      popup_in_duration + index * 200
    )





$document.on "click", ".projects-popup .close-button-and-text, #projects-popup-button-close", ()->
  $projects_popup = $(".projects-popup")
  $projects_popup.removeClass("ready")
  $projects_popup.addClass("play-closing-animation")
  close_menu("projects-popup")
  $projects_popup.find(".project, .more-projects-soon").removeClass("show")

  $projects_popup.addClass("hide")
  setTimeout(
    ()->
      $projects_popup.removeClass("show hide")
    500
  )



$document.on "ready page:load", ()->
  $btn = $("#projects-popup-button, #welcome-scroll-down")
  setTimeout(
    ()->
      if !$btn.hasClass("visible")
        $btn.addClass("visible")
    6000
  )
