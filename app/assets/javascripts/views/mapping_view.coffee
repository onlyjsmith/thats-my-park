class window.MappingView
  constructor: (@farm) ->
    @render()
    @setupBindings()

  render: ->
    $('body').html(
      @template(name: @farm.name)
    )
    @createMap()

  template: (attributes) ->
    """
      <h1>#{attributes.name}</h1>
      <button id="finish-mapping">Finish</button>
      <button id="undo-point">Undo last</button>
      <div id="map" style="height: 180px;"></div>
      <button id="mark-point">Mark Point</button>
    """

  createMap: ->
    @map = L.map('map').setView([51.505, -0.09], 13)
    osmUrl='http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
    osmAttrib='Map data © <a href="http://openstreetmap.org">OpenStreetMap</a> contributors'
    osm = new L.TileLayer(osmUrl, {minZoom: 8, maxZoom: 12, attribution: osmAttrib})
    @map.addLayer(osm)

    @map.locate({setView : true})

  setupBindings: ->
    $('#mark-point').on('click', @addPoint)
    $('#undo-point').on('click', @deleteLastPoint)
    $('#finish-mapping').on('click', @finish)

  addPoint: =>
    @getUserLocation((latlng)=>
      @farm.addPoint(latlng)
    )

  getUserLocation: (callback) ->
    foundListener = null
    foundListener = (e) =>
      callback(e.latlng)
      @map.off(foundListener)
      
    @map.on('locationfound', foundListener)
    @map.locate()

  deleteLastPoint: =>
    @farm.removePoint()

  finish: =>
    alert(@farm.points)

