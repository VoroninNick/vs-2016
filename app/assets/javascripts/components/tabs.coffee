$document.on "click", ".tab-header", (e)->
  e.preventDefault()

$document.on "click", ".tab-header:not(.active)", ()->
  $tab_header = $(this)

  $tab_headers_container = $tab_header.closest(".tab-headers")
  $tabs_container = $tab_headers_container.closest(".tabs")
  $tab_contents_container = $tabs_container.find(".tab-contents")
  $tab_contents_container.find(".tab-content.active").removeClass("active")

  $tab_headers_container.find(".tab-header.active").removeClass("active")
  $tab_header.addClass("active")
  tab_index = $tab_header.index()
  $tab_content = $tab_contents_container.find(".tab-content").eq(tab_index)
  $tab_content.addClass("active")


