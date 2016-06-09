$document.on "click", "[data-tag-key]", (e)->
  e.preventDefault()

  $tag_a = $(this)
  $tag = $tag_a.parent()
  $tag.toggleClass("checked")

