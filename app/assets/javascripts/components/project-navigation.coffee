#on_element_appear = ()->
#  console.log "appear: this: ", this, "; arguments: ", arguments
#on_element_disappear = ()->
#  console.log "disappear: this: ", this, "; arguments: ", arguments
#
#get_selector = ()->
#  selector = $(".project-navigation a").map(
#    ()->
#      $(this).attr("href")
#  ).toArray().join(", ")
#get_elements = ()->
#
#
#  $(get_selector)
#
#$document.on "ready page:load", ()->
#
#  selector = get_selector()
#  console.log "selector: ", selector
#  $elements = $(selector)
#  console.log "elements_count: ", $elements.length
#
#  #console.log "selector", selector
#  #$document.on "appear", selector, on_element_appear
#  $elements.on "appear", on_element_appear
#
#  $elements.on "disappear", on_element_disappear
#
#$window.on "scroll", ()->
#  $elements = get_elements()
#  console.log "$elements", $elements
#  selector = $elements.filter(":appeared").map(
#    ()->
#      id = "#" + $(this).attr("id")
#      "[href='#{id}']"
#  ).toArray()[0]
#  console.log "selector: ", selector
#  #$(".project-navigation").find("a").not(selector).removeClass("active")
#  #$(".project-navigation").find("a").filter(selector).addClass("active")
#
#
#
#$("#project-case").on "appear", ()->
#  console.log("appear", this)
#
#$("#project-case").appear()