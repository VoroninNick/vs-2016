
$document.on "ready page:load", ->
  $page_banner = $(".page-banner")
  setTimeout(
    ->
      $page_banner.find('.number').addClass('visible')
      $page_banner.find('.counter').counterUp(
        time: 500
      )
    2500
  )
  setTimeout(
    ->
      $page_banner.find('.number-with-subtitle .subtitle').addClass('visible')
    3000
  )
