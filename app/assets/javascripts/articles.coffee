show_articles = ($container)->
  $container ?= $(".articles")
  $container.find(".article").each (index)->
    $article = $(this)

    setTimeout(
      ()->
        $article.addClass("visible")
      index * 300
    )

$document.on "appear", ".articles", ()->
  show_articles($(this))

$document.on "ready page:load", ->
  if is_small()
    $('.tags').on 'click', ()->
      event.preventDefault()
      $(this).siblings().removeClass('opened')
      $(this).toggleClass('opened')


  $articles = $(".articles")
  $articles.appear()
  $articles.filter(":appeared").trigger("appear")



$document.on "click", "[data-tag-key]", (e)->
  e.preventDefault()

  $tag_a = $(this)
  $tag = $tag_a.parent()
  $tag.toggleClass("checked")

  load_articles()


load_articles = ()->
  tags = $(".tags:not([tag-group]) .tag.checked a").map(
    ()->
      $(this).attr("data-tag-key")
  ).toArray().join(",")

  authors = $(".tags[tag-group] .tag.checked a").map(
    ()->
      $(this).attr("data-tag-key")
  ).toArray().join(",")

  base_url = $(".articles-index").attr("data-url")
  url = "/ajax#{base_url}/filters/tags__#{tags}___authors__#{authors}.html"
  $.ajax(
    url: url
    success: (data)->
      $(".articles").replaceWith(data)
      show_articles()
  )

