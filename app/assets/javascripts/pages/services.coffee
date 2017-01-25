$document.on "ready page:load", ->

  $services = $(".services .service")
  $service_related_selector = $(".services .service .service-icon, .services .service .service-name, .services .service .service-description, .services .service .item-links")
  $service_related_selector.appear()
  $service_related_selector.filter(":appeared").trigger("appear")

$document.on "appear", ".services .service .service-icon", ()->
  $(this).addClass("visible")

$document.on "appear", ".services .service .service-name", ()->
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

$document.on "appear", ".services .service .service-description", ()->
  $(this).addClass("visible")

$document.on "appear", ".services .service .item-links", ()->
  $(this).addClass("visible")

$document.on "mouseenter", ".services .service .read-more-link, .services .service .service-name", ()->
  $(this).closest(".service").find(".service-image").addClass("hover")

$document.on "mouseleave", ".services .service .read-more-link, .services .service .service-name", ()->
  $(this).closest(".service").find(".service-image").removeClass("hover")