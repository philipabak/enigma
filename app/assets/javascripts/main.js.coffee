resizeMainHead = (target)->
  $(target).each ->
    $this = $(this)
    ratio = $this.parent().width() / $this.width()
    $this.css
      'transform': 'scale(' + ratio + ')'

resizeCanvas = ->
  resizeMainHead('.main-head')

  canvasHeight = $(window).height()
  canvasWidth = $(window).width()
  slideHeight = canvasHeight - $('#main-nav').height() - $('.row-top').height() - 30

  if canvasWidth < 768
    $('.slick-item, .card.expandable').css
      'height': slideHeight
    $('.item-expandable .card.expandable').css
      'height': 'auto'
      'min-height': slideHeight
    $('.news-grid').css
      'height': slideHeight - 90

updateTime = ->
  time = new Date
  if time.getHours() < 10 then zeroStringHrs = '0' else zeroStringHrs = ''
  if time.getMinutes() < 10 then zeroStringMins = '0' else zeroStringMins = ''
  $('.current-time').html zeroStringHrs + time.getHours() + ':' + zeroStringMins + time.getMinutes()

inintialize = ->
  map = null
  initialSlide = 0
  resizeCanvas()
  updateTime()

  if location.pathname == '/'
    hash = location.hash
    unless hash == ''
      initialSlide = $('.slide-wrap').children().index($(hash))

  $('#tab-slider').slick
    asNavFor: '#main-slider .slide-wrap'
    infinite: true
    slidesToShow: 8
    responsive: [
      {
        breakpoint: 767,
        settings:
          arrows: false
          slidesToShow: 4
      }
    ]

  $('#main-slider .slide-wrap')
    .slick
      arrows: true
      asNavFor: '#tab-slider'
      infinite: true
      slidesToShow: 2
      slidesToScroll: 1
      swipeToSlide: true
      responsive: [
        {
          breakpoint: 767,
          settings:
            slidesToShow: 1
        }
      ]
    .on 'beforeChange', (slick, currentSlide, nextSlide) ->
      if $('.item-expandable.open').length > 0
        $('.item-expandable.open').removeClass 'open'
    .on 'afterChange', (slick, currentSlide) ->
      $('[data-target="#main-slider"].active').removeClass 'active'
      $('[data-slide-to="' + currentSlide.currentSlide + '"]').addClass 'active'

  $('#main-slider .slide-wrap').slick 'slickGoTo', initialSlide if initialSlide > 0

  $('[data-target="#main-slider"]').click (e) ->
    if location.pathname == '/'
      e.preventDefault()
      $('#main-slider .slide-wrap').slick 'slickGoTo', $(this).data('slide-to')
      false

  $('.toggle-content').click (e) ->
    e.preventDefault()
    $target = $('#' + $(this).data('target'))
    return unless $target.length > 0
    $target.toggleClass 'open'
    if $target.find('#live-traffic-map').length && map
      resizeMap(map)

  $('.tabbable .expand-key').click (e) ->
    e.preventDefault()
    $this = $(this)
    $parent = $this.parent()
    opened = $parent.hasClass('open')
    $this.closest('.tabbable').find('li').removeClass('open')
    $scrollable = $this.closest('.nano')

    unless opened
      $parent.addClass('open').find('.tab-content').slideDown ->
        $scrollable.nanoScroller()
    else
      $this.closest('.tabbable').find('.tab-content').slideUp ->
        $scrollable.nanoScroller()

  $('.nano')
    .nanoScroller(alwaysVisible: true)
    .on 'update', (e) ->
      $(this).addClass 'scrollable'
    .bind 'scrollend', (e) ->
      $('.scrollable').removeClass 'scrollable'

  setInterval updateTime, 60000
  $('[data-toggle="popover"]').popover
    container: 'body'
    html: true
    placement: 'top'
    trigger: 'hover'

  if window.google
    if $('#live-traffic-map').length > 0
      trafficMap = initializeMap 'live-traffic-map',
        zoomControl: true
        #panControl: true
        #draggable: true
    if $('#contact-map').length > 0
      window.markers = []
      latLng = { lat: 51.5695, lng: 0.679 }
      conatcMap = initializeMap 'contact-map',
        zoomControl: true
        lat: latLng.lat
        lng: latLng.lng
        zoom: 15
      showMarkerOnMap(conatcMap, latLng, 'Enigma Vehicle System')

$(document).ready ->
  inintialize()

$(window)
  .on 'page:load', ->
    inintialize()
  .resize ->
    resizeCanvas()