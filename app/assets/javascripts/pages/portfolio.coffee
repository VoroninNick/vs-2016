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
  $portfolio.on "appear", ()->
    init_projects($portfolio)

$document.on "click", ".project-tags .tag:not(.checked)", (e)->
  e.preventDefault()
  $tag = $(this)
  $container = $tag.parent()
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
  )