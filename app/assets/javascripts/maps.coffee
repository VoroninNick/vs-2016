init_google_map = ->

  $map_wrapper = $(this)

  initialized_map = $map_wrapper.hasClass("initialized")

  if initialized_map
    return

  $map_wrapper.addClass("initialized")

  HOME_MAPTYPE_ID = 'plit_style'
  map = undefined

  marker = undefined
  homeStyleProperties = [ {
    featureType: 'all'
    stylers: [
      { 'saturation': -90 }
      { 'lightness': -10 }
      { 'gamma': 0.9 }
      { 'hue': '#003bff'}
    ]
  } ]
  styledMapOptions = name: 'plit style'
  customMapType = new (google.maps.StyledMapType)(homeStyleProperties, styledMapOptions)

  data_markers_str = $map_wrapper.attr('data-markers')
  marker = { location: $map_wrapper.attr("data-marker")}
  marker.lat = parseFloat(marker.location.split(", ")[0])
  marker.lng = parseFloat(marker.location.split(", ")[1])

  map_container = $map_wrapper.find('.map-container').get(0)

  mapCenter = new (google.maps.LatLng)(marker.lat, marker.lng)
  map = new (google.maps.Map)(map_container,
    scrollwheel: false
    zoom: 16
    center: mapCenter
    mapTypeId: HOME_MAPTYPE_ID)
  map.mapTypes.set HOME_MAPTYPE_ID, customMapType

  $marker = $map_wrapper.find(".marker")


  #$marker = $('<div class="appartment-marker"><div class="marker-tooltip"></div><a href="' + m.apartment_url + '">marker.svg</a></div>')
  $tooltip = $map_wrapper.find('.info-window')
  html_marker = $marker.get(0)


  map_marker = new RichMarker(
    map: map
    position: new (google.maps.LatLng)(marker.lat, marker.lng)
    draggable: false
    flat: true
    anchor: RichMarkerPosition.MIDDLE
    content: html_marker)

  google.maps.event.addListener marker, 'position_changed', ->
    log 'Marker position: ' + marker.getPosition()


  if data_markers_str
    markers = []
    data_markers = $.parseJSON(data_markers_str)
    first_marker = data_markers[0]

    console.log 'hello'
    i = 0
    while i < data_markers.length
      m = data_markers[i]
      $div = jQuery('<div class="appartment-marker"><div class="marker-tooltip"></div><a href="' + m.apartment_url + '">marker.svg</a></div>')
      $marker_tooltip = $div.find('.marker-tooltip')
      $marker_tooltip.append '<a href="' + m.apartment_url + '"><div class="address-and-category"><div class="address">' + m.address + '</div><div class="category">' + m.category + '</div></div><div class="price">' + m.price + '</div></a>'
      $div.find('a').on 'click', (event) ->

      div = $div.get(0)
      marker = new RichMarker(
        map: map
        position: new (google.maps.LatLng)(m.lat, m.lng)
        draggable: false
        flat: true
        anchor: RichMarkerPosition.MIDDLE
        content: div)
      google.maps.event.addListener marker, 'position_changed', ->
        log 'Marker position: ' + marker.getPosition()

      i++


$document.on 'ready page:load', ->
  $(".map-wrapper:visible").each ->

    init_google_map.call(this)

open_marker = ()->
  $marker = $(this)
  $info_window = $marker.closest(".map-wrapper").children().filter(".info-window")
  $marker.addClass("opened")

  $info_window.addClass("opened")

  marker_offset = $marker.offset()
  info_window_offset = $info_window.offset()

  info_window_height = $info_window.height()

  info_window_half_width = $info_window.width() / 2
  info_window_half_height = info_window_height / 2

  info_window_indent = 20

  y_diff = marker_offset.top - info_window_offset.top - info_window_height - info_window_indent
  x_diff = marker_offset.left - info_window_offset.left - info_window_half_width + $marker.width() / 2


  x_diff_str = x_diff
  if x_diff < 0
    x_diff_str = "-=#{x_diff * -1}"
  else if x_diff_str > 0
    x_diff_str = "+=#{x_diff}"

  y_diff_str = y_diff
  if x_diff < 0
    y_diff_str = "-=#{y_diff * -1}"
  else if y_diff_str > 0
    y_diff_str = "+=#{y_diff}"

  props = {}

  if x_diff_str
    props.marginLeft = x_diff_str

  if y_diff_str
    props.marginTop = y_diff_str

  $info_window.css(props)




close_marker = ()->
  $(this).removeClass("opened")
  $(this).closest(".map-wrapper").children().filter(".info-window").removeClass("opened")
toggle_marker = ()->
  if $(this).hasClass("opened")
    close_marker.apply(this)
  else
    open_marker.apply(this)


$document.on "click", ".marker-icon", ()->
  $marker = $(this).closest(".marker")
  toggle_marker.apply($marker)




$.clickOut(".info-window",
  ()->
    $marker = $(this).closest(".map-wrapper").find(".marker")
    close_marker.apply($marker)
  {except: ".marker .marker-icon"}
)


$document.on "click", ".multiple-maps-container .map-links .map-link:not(.active)", ()->
  $container = $(this).closest(".multiple-maps-container")
  $container.find(".maps > .map-wrapper")

  tab_index = $(this).index()
  $tabs = $(".maps > .tab-content")
  $tab = $tabs.filter(":eq(#{tab_index})")

  $tab_headers = $(this).closest(".map-links").find("> .map-link")
  $tab_header = $(this)

  $tab_headers.removeClass("active")
  $tab_header.addClass("active")
  $tabs.removeClass("active")
  $tab.addClass("active")



  $active_map = $tab.find(".map-wrapper")
  init_google_map.call($active_map)




