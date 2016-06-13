

#$document.on "ready turbolinks:load turbolinks:before-render turbolinks:render turbolinks:click page:change", (e)->
  #alert(e.type)



$document.on "ready page:load", ()->
  $(".svg-icon.svg-icon-location").append(svg_images.location)