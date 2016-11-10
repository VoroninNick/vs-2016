revealerOpts = {
  # the layers are the elements that move from the sides
  nmbLayers : 3,
  # bg color of each layer
  bgcolor : ['#0092DD', '#fff', '#3E3A35'],
  # effect classname
  effect : 'anim--effect-3',
  onStart : (direction)->
    # next page gets class page--animate-[direction]
    #nextPage = pages[if currentPage == 0 then 1 else 0];
    #classie.add(nextPage, 'page--animate-' + direction);
  ,
  onEnd : (direction)->
    # remove class page--animate-[direction] from next page
    nextPage = pages[if currentPage == 0 then 1 else 0];
    nextPage.className = 'page';

}

default_slide_duration = 300
#default_slide_duration = 1000

window.show_slide = (number, percent, $container, klass = "animated")->
  $(".reveal-#{number}").remove()
  $container ?= $("body")

  element_style = ""
  if percent > 0
    element_style = "style='height: #{percent}%'"
  $element = $("<div class='reveal-1' #{element_style}></div>")
  console.log "revealer-wrap: " + $container.find("#revealer-wrap").length
  $container.find("#revealer-wrap").append($element)

  if !$element.hasClass(klass)
    $element.addClass(klass)

destroy_slide = (number, timeout = 0)->
  if timeout
    setTimeout(
      ()->
        $(".reveal-#{number}").remove()
      timeout
    )
  else
    $(".reveal-#{number}").remove()


window.start_revealer = (percent = 0)->
  show_slide(1, percent)





show_progress = ()->
  setTimeout(
    ()->
      $(".reveal-2").addClass("animated")
    default_slide_duration
  )
  $element = $("<div class='reveal-2'></div>")

  $("#revealer-wrap").append($element)
#  $element.addClass("animated")

show_slide3 = ()->
  setTimeout(
    ()->
      $(".reveal-3").addClass("animated")
    default_slide_duration
  )

  setTimeout(
    ()->
      $(".reveal-3").addClass("animate-hide-up")
    default_slide_duration
  )
  
  $element = $("<div class='reveal-3'></div>")
  $("#revealer-wrap").append($element)


build_progress_indicator = (count = 5)->

  $indicator = $("<div class='load-progress-indicator'>#{count}</div>")
  window.load_progress = count
  $(".reveal-1").append($indicator)

start_progress_indicator = ()->
  window.load_progress_timeout = setInterval(
    ()->
      if window.load_progress < 100
        console.log "load_progress:", window.load_progress
        $indicator = $(".load-progress-indicator")
        window.load_progress += 1
        if window.load_progress > 100
          window.load_progress = 100
        $indicator.text(window.load_progress)
      else
        clearInterval(window.load_progress_timeout)
        window.load_progress_timeout = null
    200
  )

add_logo_to_reveal = ()->
  if !$(".load-progress-logo-wrap").length
    $logo = $("<div class='load-progress-logo-wrap'>#{window.svg_images.logo}</div>")
    $(".reveal-1").append($logo)

$document.on "page:fetch", ()->
  window.page_fetching = true
  window.page_fetch_time = Date.now()
  start_revealer()
  #build_progress_indicator()
  #start_progress_indicator()
  add_logo_to_reveal()


  #show_progress()

$document.on "page:change", (e)->
  #alert("hi")
  console.log "#{e.type}"
  if !window.page_fetching
    return

  window.page_fetching = false

  progress = Date.now() - window.page_fetch_time
  slide1_duration = default_slide_duration
  remaining = slide1_duration - progress

  slide2_duration = default_slide_duration
  slide2_remaining = remaining + slide2_duration

  if progress < slide1_duration
    percent = progress / slide1_duration * 100
  else if progress > slide1_duration
    progress = percent - 1
  else if progress == 0
    percent = 0


  #show_slide(1, percent)
  #show_progress()
  #show_slide3()

  console.log "slide2_remaining", slide2_remaining

  #destroy_slide(1, remaining)
  #destroy_slide(2, slide2_remaining)
  #destroy_slide(3, default_slide_duration * 99999)

revealer = new Revealer(revealerOpts);
$('button.pagenav__button--top').on 'click', ()->
  #reveal('top')


$document.on "page:fetch", (e)->
  #reveal('top')
  #$("body").append("<div style='background: red; position: fixed; width: 10%; height: 100%; top: 0; left: 0;z-index: 99999999;'><div style='color: white; font-size: 20px'>#{e.type}</div></div>")
  #alert(e.type)
$document.on "page:receive", (e)->
  #alert(e.type)
  #$("body").append("<div style='background: orange; position: fixed; width: 10%; height: 100%; top: 0; left: 0;z-index: 99999999;'><div style='color: white; font-size: 20px'>#{e.type}</div></div>")

$document.on "page:change", (e)->
  #alert(e.type)
  #$("body").append("<div style='background: green; position: fixed; width: 10%; height: 100%; top: 0; left: 0;z-index: 99999999;'><div style='color: white; font-size: 20px'>#{e.type}</div></div>")



reveal = (direction)-> 
  callbackTime = 750
  callbackFn = ()-> 
    #classie.remove(pages[currentPage], 'page--current');

    #currentPage = if currentPage == 0 then 1 else 0;
    #classie.add(pages[currentPage], 'page--current');
  
  
  revealer.reveal(direction, callbackTime, callbackFn);

hide_slide = ()->
  setTimeout(
    ()->
      $(".reveal-1").css("bottom", "100%")
    150
  )


$document.on "page:load", (e)->
  #alert("#{e.type}")
  #console.log "e: #{e.type}; args: ", arguments
  $new_body = $(e.originalEvent.data)
  $new_body.addClass("new-body")
  #show_slide(1, 100, $new_body)
  #start_revealer()
  #alert("1")
  #$(".reveal-1").addClass("hide")
  #start_revealer()
  show_slide(1, 100, $new_body, "finished")
  add_logo_to_reveal()
  hide_slide()
  console.log("reveal: " + $(".reveal-1").length)
  #$(".reveal-1").fadeOut(500)
  $(".reveal-1")
#  $(".reveal-1").addClass("hide")
#  setTimeout(
#    ()->
#      $(".reveal-1").remove()
#    1000
#  )





$document.on "load"