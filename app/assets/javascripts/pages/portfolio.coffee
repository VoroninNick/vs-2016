$document.on "ready page:load", ->

  $portfolio = $(".portfolio-projects")
  $portfolio.appear()
  $portfolio.on "appear", ()->
    $portfolio.find(".project").each (index)->
      $project = $(this)
      
      setTimeout(
        ()->
          $project.addClass("visible")
        index * 300
      )