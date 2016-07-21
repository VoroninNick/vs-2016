popup_in_duration = 2000
$document.on "click", "#projects-popup-button", ()->
  $projects_popup = $(".projects-popup")
  $projects_popup.find(".project, .more-projects-soon").each (index)->
    $project = $(this)
    transition_delay_str = "#{1000 + index * 100}ms"
    
    setTimeout(
      ()->
        $project.addClass("show")
      popup_in_duration + index * 200
    )
  $projects_popup.addClass("show")
  $projects_popup.addClass("animate-open")
  opened = open_menu("projects-popup")
  setTimeout(
    ()->
      $projects_popup.addClass("ready")
    popup_in_duration
  )
  #addClass("opened")


    


$document.on "click", ".projects-popup .close-button-and-text", ()->
  $projects_popup = $(".projects-popup")
  $projects_popup.removeClass("ready")
  $projects_popup.addClass("play-closing-animation")
  close_menu("projects-popup")

  setTimeout(
    ()->
      $projects_popup.removeClass("show")
    1000
  )