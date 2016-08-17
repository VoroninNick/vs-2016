window.$document = $(document)
window.$window = $(window)

window.breakpoints = {
  small: [0, 640]
  mobile_sidebar: [0, 768]
}

window.is_small = ()->
  window.innerWidth <= window.breakpoints.small[1]

window.is_medium = ()->
  window.innerWidth > 640 || window.innerWidth > 1024

landscape = ()->
  $(window).resize ()->
    window.innerHeight < window.innerWidth
