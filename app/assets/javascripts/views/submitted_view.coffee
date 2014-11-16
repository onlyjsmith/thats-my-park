class window.SubmittedView
  constructor: (@farm) ->
    @render()

  render: ->
    $('body').html(
      @template(name: @farm.name)
    )
    @renderFinishedMap()  

  template: ->
    map_height = $(document).height() - 350
    """
      <div class="container clearfix">
        <p class="you-submitted">You submitted this boundary</p>
        <div id="map" style="height:#{map_height}px"></div>
      </div>
    """

  renderFinishedMap: ->
    @createMap()
    @polygon = L.polygon(@farm.points)
    @polygon.addTo(@map)
    @map.fitBounds(@polygon.getBounds())

  createMap: ->
    @map = L.map('map').setView([51.505, -0.09], 13)
    osmUrl='http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
    osmAttrib='Map data © <a href="http://openstreetmap.org">OpenStreetMap</a> contributors'
    osm = new L.TileLayer(osmUrl, {attribution: osmAttrib})
    @map.addLayer(osm)

