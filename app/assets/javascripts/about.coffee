shuffle_clients = ()->
  $(".shuffle-container:not(.shuffled)").each(
    ()->
      $container = $(this)
      $container.addClass("shuffled")
      shuffled_str = $container.children().map(
        ()->
          this.outerHTML
      ).toArray().shuffle().join("")

      $container.html(shuffled_str)
  )

shuffle_clients()
$document.on "ready page:load", shuffle_clients