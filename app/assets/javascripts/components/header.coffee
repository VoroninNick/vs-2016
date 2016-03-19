open_menu = ()->
  $("body").addClass("has-opened-menu")
close_menu = ()->
  $("body").removeClass("has-opened-menu")
$("#main-menu-button").on "click", ()->
  if !$("body").hasClass("has-opened-menu")
    open_menu()
  else
    close_menu()

