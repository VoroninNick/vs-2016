$document.on "ready page:load", ->
  if is_small()
    $('.tags').on 'click', ()->
      event.preventDefault()
      $(this).siblings().removeClass('opened')
      $(this).toggleClass('opened')


  $articles = $(".articles")
  $articles.appear()
  $articles.on "appear", ()->
    $articles.find(".article").each (index)->
      $article = $(this)
      
      setTimeout(
        ()->
          $article.addClass("visible")
        index * 300
      )