
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

  $("#home-footer").appear()





$document.on "click", "#welcome-block .play-link", ()->
  $("body").addClass("has-opened-video-popup")
  home_full_play()


$document.on "click", "#home-full-video-popup-close-button", ()->
  $("body").removeClass("has-opened-video-popup")
  home_full_stop()

###
$document.on "appear", "#home-footer", (e)->
  if window.innerWidth <= 640
    console.log "e: ", e
    $("body, html").animate(scrollTop: 10000)
###