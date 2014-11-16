class window.Farm
  constructor: (@name) ->
    @points = []

  addPoint: (point) ->
    @points.push(point)

  removePoint: ->
    @points.pop()

  submitPoints: ->
    query = @buildInsertQuery()
    $.post('/farms/create', query: query)

  buildInsertQuery: ->
    """
      INSERT INTO thats_my_farm (name, the_geom)
      VALUES ('#{@name}', '#{@pointsToPolygon()}')
    """

  pointsToPolygon: ->
    "POLYGON ((30 10, 40 40, 20 40, 10 20, 30 10))"
