$document.on "ready page:load", ->
  $large_header = $(".large-header")
  $large_header.appear()
  $large_header.filter(":appeared").trigger("appear")



  $header = $(".office .header")
  $header.appear()
  $header.filter(":appeared").trigger("appear")

  $phone = $('.numbers')

  setTimeout (->
    if !$phone.hasClass("visible")
      $phone.addClass("visible")
  ), 2500

  $contact_info_container = $(".contact-info-container")
  $contact_info_container.appear()
  $contact_info_container.filter(":appeared").trigger("appear")



  $contact_social = $(".contacts-social")
  $contact_social.appear()
  $contact_social.filter(":appeared").trigger("appear")

  $tabs = $(".tabs")
  $tabs.appear()
  $tabs.filter(":appeared").trigger("appear")




$document.on "appear", ".large-header", ()->
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


$document.on "appear", ".office .header", ()->
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


$document.on "appear", ".contacts-social, .tabs, .contact-info-container", ()->
  $element = $(this)
  if !$element.hasClass('visible')
    $element.addClass('visible')