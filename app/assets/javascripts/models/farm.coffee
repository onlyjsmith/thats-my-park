class window.Farm
  constructor: (@name) ->
    @points = []

  addPoint: (point) ->
    @points.push(point)

  removePoint: ->
    @points.pop()
