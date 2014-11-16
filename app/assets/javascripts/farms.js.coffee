$(document).ready(->
  newFarmView = new NewFarmView()
  newFarmView.onFarmCreated(startLocationTracking)
)

startLocationTracking = (farm) ->
  farm
