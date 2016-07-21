$services = $(".services .service")
$service_related_selector = $(".services .service .service-name, .services .service .service-description")
$service_related_selector.appear()

$services.on "appear", ".service-name", ()->
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

$services.on "appear", ".service-description", ()->
  $(this).addClass("visible")

$services.on "mouseenter", ".read-more-link, .service-name", ()->
  $(this).closest(".service").find(".service-image").addClass("hover")

$services.on "mouseleave", ".read-more-link, .service-name", ()->
  $(this).closest(".service").find(".service-image").removeClass("hover")




#
#
#  $service = $(this)
#  if !$service.hasClass("visible")
#
#    $service.find("")
#    #$(this).addClass("visible")