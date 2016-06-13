init_google_map = ->
  $map_wrapper = $(this)
  HOME_MAPTYPE_ID = 'plit_style'
  map = undefined

  marker = undefined
  homeStyleProperties = [ {
    featureType: 'all'
    stylers: [
      { 'saturation': -29 }
      { 'lightness': 5 }
      { 'gamma': 0.88 },
      {hue: '#3bff00'}
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
    scrollwheel: true
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

    #var div = document.createElement('DIV');
    #div.innerHTML = '<div class="my-other-marker">I am flat marker!</div>';
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
  $(".map-wrapper").each ->

    init_google_map.call(this)

open_marker = ()->
  $(this).addClass("opened")
  $(this).closest(".map-wrapper").children().filter(".info-window").addClass("opened")
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

