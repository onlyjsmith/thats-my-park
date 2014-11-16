$(document).ready(->
  newFarmView = new NewFarmView()
  newFarmView.onFarmCreated(startLocationTracking)
)

startLocationTracking = (farm) ->
  mappingView = new MappingView(farm)
  mappingView.whenSubmitted(showSubmittedView)

showSubmittedView = (farm)->
  new SubmittedView(farm)
