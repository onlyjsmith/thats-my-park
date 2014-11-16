class window.MappingView
  constructor: (@farm) ->
    @render()
    @setupBindings()

  render: ->
    $('body').html(
      @template(name: @farm.name)
    )

  template: (attributes) ->
    """
      <h1>#{attributes.name}</h1>
      <button id="finish-mapping">Finish</button>
      <button id="undo-point">Undo last</button>
      <button id="mark-point">Mark Point</button>
    """

  setupBindings: ->
    $('#mark-point').on('click', @addPoint)
    $('#undo-point').on('click', @deleteLastPoint)
    $('#finish-mapping').on('click', @finish)

  addPoint: =>
    @farm.addPoint([52, 0])

  deleteLastPoint: =>
    @farm.removePoint()

  finish: =>
    alert(@farm.points)

