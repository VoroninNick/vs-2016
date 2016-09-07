$document.on "ready page:load", ->
  $large_header = $(".large-header")
  $large_header.appear()

  $large_header.on "appear", ()->
    $element = $(this)
    if !$element.hasClass("textillated")
      $element.addClass("visible")
      $element.addClass("textillated")
      $element.textillate({
        in: {
          effect: "fadeIn"
          delay: 50
        }
      })

  $header = $(".office .header")
  $header.appear()

  $header.on "appear", ()->
    $element = $(this)
    if !$element.hasClass("textillated")
      $element.addClass("visible")
      $element.addClass("textillated")
      $element.textillate({
        in: {
          effect: "fadeIn"
          delay: 50
        }
      })

  $contact_info_container = $(".contact-info-container")
  $contact_info_container.appear()

  $contact_info_container.on "appear", ()->
    $element = $(this)
    $element.addClass('visible')

  $contact_social = $(".contacts-social")
  $contact_social.appear()

  $contact_social.on "appear", ()->
    $element = $(this)
    $element.addClass('visible')