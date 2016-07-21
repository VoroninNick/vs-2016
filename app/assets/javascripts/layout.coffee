$document.on "click", "#projects-popup-button", ()->
  $projects_popup = $(".projects-popup")
  $projects_popup.addClass("animate-open")
  opened = open_menu("projects-popup")
  setTimeout(
    ()->

      $projects_popup.removeClass("animate-popup")
    1000
  )
  addClass("opened")


$document.on "click", ".projects-popup .close-button-and-text", ()->
  close_menu("projects-popup")