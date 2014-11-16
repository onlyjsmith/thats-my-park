'use strict';

/* Controllers */

(function () {

  function MainCtrl($q, $scope, $window, $http, DataService) {
    // my model
    var data = $scope.data = {};
    //$scope.data.t = 'ssssssssss';

    var resource = DataService.getTableData();
    $scope.data.resource = resource;
    $scope.data.overlapResource = DataService.getOverlapTableData();

    console.log('xxxxxxxxx', $scope.data.overlapResource);


    $scope.data.overlapResource.then(function(res) {
      
      console.log('rrrrrrrrrrr', res);
    })

  }

  angular.module('App')
    .controller('MainCtrl', MainCtrl);

})();



