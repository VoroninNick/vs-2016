
$document.on "ready page:load", ->

  $welcome_page_section = $('#welcome-page-section')

  $welcome_block = $welcome_page_section.find("#welcome-block")

  setTimeout(
    ->
      if !$welcome_block.hasClass("animated")
        $welcome_block.addClass("animated")
        $welcome_block.find(".white-header").textillate({
          in: {
            effect: "fadeIn"
            delay: 35 # 35
          }
        })

    2000
  )





$document.on "click", "#welcome-block .play-link", ()->
  $("body").addClass("has-opened-video-popup")
  home_full_play()


$document.on "click", "#home-full-video-popup-close-button", ()->
  $("body").removeClass("has-opened-video-popup")
  home_full_stop()