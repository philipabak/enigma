window.resizeMap = (map) ->
  setTimeout ->
    return if typeof(map) == undefined
    center = map.getCenter()
    google.maps.event.trigger(map, 'resize')
    map.setCenter(center)
  , 500

window.deleteMarkers = ->
  for marker in window.markers
    marker.setMap null
  window.markers = []

window.showMarkerOnMap = (map, latLng, title, pushMarker=false) ->
  marker = new (google.maps.Marker)(
    map: map
    position: latLng
    title: title)

  window.markers.push marker if pushMarker

window.initializeMap = (el, options={}) ->
  mapOptions =
    center:
      lat: parseFloat(options.lat) || 51.9214619
      lng: parseFloat(options.lng) || 0.925388
    zoom: parseInt(options.zoom) || 16
    zoomControl: options.zoomControl || false
    panControl: options.panControl || false
    streetViewControl: false
    mapTypeControl: options.mapTypeControl || false
    draggable: options.draggable || false
    disableDoubleClickZoom: true
    scrollwheel: options.scrollwheel || false
    navigationControl: false

  map = new (google.maps.Map)(document.getElementById(el), mapOptions)
  resizeMap(map)
  map