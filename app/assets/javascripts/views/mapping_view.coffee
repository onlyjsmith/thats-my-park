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
    map_height = $(document).height() - 350
    """
    <div class="button-row">
      <a id="finish-mapping" href="#" class="button medium finish">FINISH</a>
      <a id="undo-point" href="#" class="button medium undo">UNDO LAST</a>
    </div>
      <div id="map" style="height:#{map_height}px"></div>
    <div class="clearfix">
      <a id="mark-point" href="#" class="button large mark">MARK POINT</a>
      <small>#{attributes.name}</small>
    </div>
    """

  createMap: ->
    @map = L.map('map').setView([51.505, -0.09], 13)
    osmUrl='http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
    osmAttrib='Map data © <a href="http://openstreetmap.org">OpenStreetMap</a> contributors'
    osm = new L.TileLayer(osmUrl, {attribution: osmAttrib})
    @map.addLayer(osm)

    @map.locate({setView : true})

  setupBindings: ->
    $('#mark-point').on('click', @addPoint)
    $('#undo-point').on('click', @deleteLastPoint)
    $('#finish-mapping').on('click', @finish)

  addPoint: =>
    @farm.addPoint(@map.getCenter())
    @renderPath()

    # @getUserLocation((latlng)=>
    #   @farm.addPoint(latlng)
    #   @renderPath()
    # )

  renderPath: ->
    @map.removeLayer(@boundary) if @boundary?
    @boundary = L.polyline(@farm.points)
    @boundary.addTo(@map)

  renderPolygon: ->
    @map.removeLayer(@boundary) if @boundary?
    @boundary = L.polygon(@farm.points)
    @boundary.addTo(@map)

  getUserLocation: (callback) ->
    foundListener = null
    foundListener = (e) =>
      callback(e.latlng)
      @map.off(foundListener)
      
    @map.on('locationfound', foundListener)
    @map.locate()

  deleteLastPoint: =>
    @farm.removePoint()
    @renderPath()
    @renderFinishButton()

  finish: =>
    @renderPolygon()
    @renderSubmitButton()

  renderSubmitButton: ->
    submitButton = $("""<a id="submit-button" href="#" class="button medium submit">SUBMIT</a>""")
    $('#undo-point').before(submitButton)
    $('#finish-mapping').remove()
    submitButton.on('click', @submitPolygon)
    $("#mark-point").hide()

  renderFinishButton: ->
    return if $('#finish-mapping').length
    finishButton = $("""<a id="finish-mapping" href="#" class="button medium finish">FINISH</a>""")
    $('#undo-point').before(finishButton)
    $('#submit-button').remove()
    finishButton.on('click', @finish)
    $("#mark-point").show()

  submitPolygon: =>
    @farm.submitPoints()
