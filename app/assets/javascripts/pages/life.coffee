$document.on "click", ".life-entry-info-button", ()->
  $(this).closest(".life-entry").toggleClass("opened")
