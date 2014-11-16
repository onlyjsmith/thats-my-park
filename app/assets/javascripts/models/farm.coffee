class window.Farm
  constructor: (@name) ->
    @name ||= guid()
    @points = []

  addPoint: (point) ->
    @points.push(point)

  removePoint: ->
    @points.pop()

  submitPoints: ->
    @throwIfInvalidGeom()
    @setLastPointToFirstPoint()
    console.log "Submitting polygon:"
    console.log @points
    query = @buildInsertQuery()
    $.post('/farms', query: query)

  buildInsertQuery: ->
    """
      INSERT INTO thats_my_farm (name, the_geom)
      VALUES ('#{@name}', '#{@pointsToPolygon()}')
    """

  pointsToPolygon: ->
    wktPoints = []
    for point in @points
      wktPoints.push "#{point.lng} #{point.lat}"

    wkt = "SRID=4326;POLYGON ((#{wktPoints.join()}))"

  throwIfInvalidGeom: ->
    unless @points.length > 2
      throw new Error("Polygons must contain >2 points, but got #{@points.length}")

  setLastPointToFirstPoint: ->
    @points.push(@points[0])
