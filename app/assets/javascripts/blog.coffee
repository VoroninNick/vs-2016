$html = $('html')
if $html.filter("[data-controller=blog][data-action=index]").length

  $window = $(window)


  #$("select#sorting_property").select2()
  $("select#sorting_property").simpleselect()
  $grid = $(".articles")
  total_pages_count = parseInt($grid.attr('data-total-pages-count'))

  disable_isotope = false

  $articles_preloader = $(".articles-preloader")

  last_loaded_page_number = 1
  last_loaded_row_number = 6

  load_in_progress = false


  if !disable_isotope
    $(document).on "ready", ()->
      $grid.isotope({
        itemSelector: ".article-item"
        getSortData: {
          date: (item)->
            Date.parse($(item).attr("data-date"))
          popularity: (item)->
#parseInt($(item).attr('data-views'))
            parseInt($(item).attr('data-popularity-position'))
          name: (item)->
            $(item).attr('data-name')
        }
      })

      setTimeout(
        ()->
          $grid.isotope()
        200
      )



  window.check_if_has_tags = (tags, attr = 'data-tag-ids')->
    if !tags || !tags.length
      return true

    $item = this

    any = false
    item_tags = $item.attr(attr).split(",").filter( (a)-> a && a.length   ).map( (item)-> parseInt(item)  )


    if tags.length
      for tag in tags
        if item_tags.indexOf(parseInt(tag)) >= 0
          return true
    else
      return true

    return false


  show_preloader = ()->
    $articles_preloader.removeClass("hide")

  hide_preloader = ()->
    $articles_preloader.addClass("hide")

  window.load_next_pages = (count = 1)->
    if !load_in_progress && last_loaded_page_number < total_pages_count
      load_in_progress = true
      show_preloader()
      page_number = last_loaded_page_number + 1
      $.ajax({
        url: "/blog"
        type: "get"
        dataType: "json"
        data: {
          ajax: true
          page: page_number
          pages_count: count
        }
        success: (data)->

          items = data.html
          #$grid.append(data.html)
          $items = $(data.html)
          elems = []
          $items.each ()->
            elems.push($(this).get(0))

          hide_preloader()
          $grid.isotope('insert', elems)

          load_in_progress = false
      })

      last_loaded_page_number = last_loaded_page_number + count

  window.load_all_pages = ()->
    load_next_pages(total_pages_count - last_loaded_page_number)




  window.sort_grid = (options = {})->
    if options.prop == undefined
      options.prop = $("select#sorting_property").val()
    if options.asc == undefined
      direction = if $(".sorting-directions .checked").hasClass("asc") then 'asc' else 'desc'
      options.asc = direction == 'asc'



    if options.prop == 'popularity' || options.prop == 'name'
      options.asc = !options.asc

    #alert("asc: #{options.asc}; prop: #{options.prop}")


    $grid.isotope({
      sortBy: options.prop
      sortAscending: options.asc
    })

  window.filter_grid = ()->
    selected_tag_ids = []
    $selected_tags = $(".tag-list .checked")
    if $selected_tags.length != 1 || !$selected_tags.hasClass("all")
      selected_tag_ids = $selected_tags.map( ()->
        return parseInt($(this).children().attr("data-tag-id"))
      ).toArray()

    console.log "selected_tags:", selected_tag_ids

    selected_author_ids = []
    $selected_authors = $(".tags.authors .checked")
    if $selected_authors.length != 1 || !$selected_authors.hasClass("all")
      selected_author_ids = $selected_authors.map( ()->
        return parseInt($(this).children().attr("data-author-id"))
      ).toArray().filter( (item)-> !isNaN(item) && item != undefined && item != null  )

    console.log "selected_author_ids: ", selected_author_ids


    if !disable_isotope
      $grid.isotope(
        filter: ()->
          $item = $(this)
          valid = true

          valid = check_if_has_tags.call($item, selected_tag_ids) && check_if_has_tags.call($item, selected_author_ids, 'data-author-ids')
          if valid
            console.log "valid"

          return valid



      )

      sort_grid()


  $("body").on "click", ".tags a", (e)->
    e.preventDefault()
    checked_class = 'checked'
    $a = $(this)
    $li = $a.closest("li")

    is_all = $li.hasClass("all")
    $ul = $li.parent()


    was_checked = $li.hasClass(checked_class)

    if is_all
      $ul.children().filter(":not(.all)").removeClass(checked_class)

    else
      $all = $ul.find('.all')

      $all.removeClass(checked_class)

    if was_checked
      $li.removeClass(checked_class)
    else
      $li.addClass(checked_class)

    if !$ul.find(".#{checked_class}").length
      $all.addClass(checked_class)


    filter_grid()


  $("body").on "click", ".sorting-directions > div:not(.checked)", ()->
    $this = $(this)
    $parent = $this.parent()
    asc = $this.hasClass("asc")
    if asc
      $parent.find('.desc').removeClass("checked")
    else
      $parent.find('.asc').removeClass('checked')

    $this.addClass('checked')


    sort_grid({asc: asc})
  #sort_grid()

  $("body").on "change", "select#sorting_property", ()->

    prop = $(this).val()
    sort_grid({prop: prop})
  #sort_grid()



  $window.on "scroll", ()->
    $items = $grid.find(".article-item")
    item_height = $items.first().outerHeight(true)
    #last_loaded_page_number *

    grid_top = $grid.offset().top
    grid_height = $grid.height()
    grid_bottom = grid_top + grid_height
    window_bottom = $window.scrollTop() + $window.height()
    items_per_row = 3
    rows_to_bottom = Math.ceil((grid_bottom - window_bottom) / item_height)

    condition_to_load = rows_to_bottom <= 3

    if condition_to_load
      load_next_pages()


  $(document).on "ready", ()->
    load_all_pages()
