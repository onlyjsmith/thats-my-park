class window.NewFarmView
  constructor: ->
    $('form#new_farm').on('submit', @createFarm)

  createFarm: (ev) =>
    ev.preventDefault()
    farmName = $(ev.target).find('#farm_name').val()
    
    @triggerFarmCreated(new Farm(farmName))

  onFarmCreated: (callback) ->
    @farmCreatedCallbacks ||= []
    @farmCreatedCallbacks.push callback

  triggerFarmCreated: (farm) ->
    for callback in @farmCreatedCallbacks
      callback(farm)
