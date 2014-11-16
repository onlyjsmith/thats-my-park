class window.NewFarmView
  constructor: ->
    $('#create-farm').on('click', @createFarm)

  createFarm: (ev) =>
    ev.preventDefault()
    farmName = $('body').find('#farm_name').val()
    
    @triggerFarmCreated(new Farm(farmName))

  onFarmCreated: (callback) ->
    @farmCreatedCallbacks ||= []
    @farmCreatedCallbacks.push callback

  triggerFarmCreated: (farm) ->
    for callback in @farmCreatedCallbacks
      callback(farm)
