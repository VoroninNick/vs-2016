###
init_menu_active_links = ()->
  $main_menu = $("#main-menu")
  $main_menu_row = $main_menu.find(".menu-row")
  $main_menu.find("a.active").removeClass("active").closest(".has-active")
  $new_links = $main_menu.find("a[href='#{location.pathname}']")
  $new_links.each ()->

    $link = $(this)
    page_link = $link.closest(".pages-menu").length > 0

    #if !page_link
    $link.addClass("active")
    $link.closest(".category").addClass("active")
    #else
    #  $link.closest("li").addClass("active")



init_menu_active_links()
###


window.store_scroll_top = ()->
  scroll_top = $("body").scrollTop() || $window.scrollTop()
  $("body").data("last_scroll_top", scroll_top)

  scroll_top

window.restore_scroll_top = ()->
  $("body,html").scrollTop($("body").data("last_scroll_top"))

###
window.init_menu_footer = (menu_dropdown_height = undefined )->
  $pages_menu = $("#main-menu .sidebar.pages-menu")
  if window.innerWidth >= breakpoints.small[1]

    total_width = $("#main-menu").width()
    content_width = $(".menu-row").width()
    #content_width = 1200
    footer_width = ((total_width - content_width) / 2) + $pages_menu.width()
    console.log "width: ", footer_width
    $("#menu-footer").width(footer_width)
    $pages_menu.css("padding-top", '')




  else
    $("#menu-footer").css('width', '')
    $catalog_menu = $(".catalog-menu")
    #catalog_menu_height = $catalog_menu.height()
    category_header_height = 61
    $categories = $catalog_menu.children().filter(".category")
    catalog_menu_height = $catalog_menu.children().filter(".line-header").outerHeight(true) + $categories.length * category_header_height
    $category_sub_menu = $categories.filter(".opened").children().filter(".category-sub-menu")
    if $category_sub_menu.length > 0
      inc = parseInt($category_sub_menu.attr("style").split(";")[0].split(':')[1])
      catalog_menu_height += inc

    header_height = $("header").height()
    menu_footer_height = $("#menu-footer").outerHeight()
    window_height = window.innerHeight

    pages_menu_height = $pages_menu.height()


    remaining_height = window_height - (header_height + catalog_menu_height + pages_menu_height + menu_footer_height + (menu_dropdown_height || 0)  )
    if remaining_height > 0
      padding_top = remaining_height
    else
      padding_top = ""

    #alert(padding_top)


    $pages_menu.css("padding-top", padding_top)
###

#init_menu_footer()

$window.on "resize", ()->
  #init_menu_footer()


window.open_menu = (menu_key = 'menu', abstract_css_class = "")->
  scroll_top = store_scroll_top()
  $("body").addClass("#{abstract_css_class} has-opened-#{menu_key}")
  $("#page-wrap").scrollTop(scroll_top)

  

window.close_menu = (menu_key = 'menu', abstract_css_class = "")->
  $("body").removeClass("#{abstract_css_class} has-opened-#{menu_key}")
  restore_scroll_top()

window.toggle_menu = (menu_key = 'menu', abstract_css_class = "" )->
  opened = $("body").hasClass("has-opened-#{menu_key}")
  if opened
    close_menu(menu_key, abstract_css_class)
  else
    open_menu(menu_key, abstract_css_class)



  return opened

window.open_contact_form_success_popup = ()->
  open_menu('contact-form-success-popup')

window.close_contact_form_success_popup = ()->
  close_menu('contact-form-success-popup')

$document.on "click", "#main-menu-button", ()->
  opened = toggle_menu()
  ###
  if !opened
    init_menu_footer()
  ###


###
$document.on "click", "#main-menu .category-header", (e)->
  if window.innerWidth <= breakpoints.small[1]
    e.preventDefault()

  $category = $(this).closest(".category")
  opened = $category.hasClass("opened")

  $("#main-menu .category").removeClass("opened").addClass("collapsed")
  #$category_products_dropdown = $category.children().filter(".category-products")
  #category_children_height = parseInt($category_products_dropdown.css('max-height'))
  #category_children_height = parseInt($category_products_dropdown.attr("style").split(";")[0].split(':')[1])
  if !opened
    $category.removeClass("collapsed").addClass("opened")

    #alert(category_children_height)
    init_menu_footer()
  else

    init_menu_footer()

###