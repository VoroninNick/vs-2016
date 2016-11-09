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

window.show_slide = (number, percent)->
  $(".reveal-#{number}").remove()

  element_style = ""
  if percent > 0
    element_style = "style='height: #{percent}%'"
  $element = $("<div class='reveal-1' #{element_style}></div>")
  $("body").append($element)

  $element.addClass("animated")

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

  $("body").append($element)
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
  $("body").append($element)

$document.on "page:fetch", ()->
  window.page_fetching = true
  window.page_fetch_time = Date.now()
  start_revealer()
  show_progress()

$document.on "page:change", (e)->
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


  show_slide(1, percent)
  show_progress()
  show_slide3()

  console.log "slide2_remaining", slide2_remaining

  destroy_slide(1, remaining)
  destroy_slide(2, slide2_remaining)
  destroy_slide(3, default_slide_duration * 99999)

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
