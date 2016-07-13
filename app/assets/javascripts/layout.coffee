$document.on "click", "#projects-popup-button", ()->
  
  opened = open_menu("projects-popup")


$document.on "click", ".projects-popup .close-button-and-text", ()->
  close_menu("projects-popup")