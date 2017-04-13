init_projects = ($portfolio)->
  $portfolio ?= $(".portfolio-projects")
  $portfolio.find(".project").each (index)->
    $project = $(this)

    setTimeout(
      ()->
        $project.addClass("visible")
      index * 300
    )

$document.on "ready page:load", ->

  $portfolio = $(".portfolio-projects")
  $portfolio.appear()
  $portfolio.filter(":appeared").trigger("appear")


$document.on "click", ".project-tags .tag:not(.checked)", (e)->
  e.preventDefault()
  $tag = $(this)
  $container = $tag.parent()
  if is_small() #&& $tag.hasClass("checked")
    $container.children().filter(".visible").each(
      (index)->
        if index > 0
          $(this).removeClass("visible")
    )
  $container.find(".checked").removeClass("checked")
  $tag.addClass("checked")
  original_url = $(this).attr("href")
  url = "/ajax#{original_url}.html"

  $.ajax(
    url: url
    dataType: "html"
    success: (data)->
      $(".projects").replaceWith(data)
      init_projects()
      $new_projects_container = $(".projects")
      $projects_count = $new_projects_container.find(".project-quantity")
      $projects_count.addClass("visible")
      $projects_count.counterUp(
        time: 500
      )
      console.log "ajax: success: counter_up"
  )

$document.on "appear", ".portfolio-projects", ()->
  $projects_container = $(".projects")

  if !$projects_container.hasClass("appeared")
    $projects_container.addClass("appeared")

    $projects_count = $projects_container.find(".project-quantity")
    $projects_count.addClass("visible")
    $projects_count.counterUp(
      time: 500
    )

    init_projects($(this))

    console.log "appear: counter_up"