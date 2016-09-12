$document.on "ready page:load", ->
  $title = $(".page-banner-description-block .title")
  setTimeout (->
    if !$title.hasClass("textillated")
      $title.addClass("visible")
      $title.addClass("textillated")
      $title.textillate({
        in: {
          effect: "fadeIn"
          delay: 50
        }
      })
  ), 1500