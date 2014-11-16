'use strict';

(function () {

  function mapD($timeout) {
    return {
      restrict: 'E',
      scope: {
        url: '@',
      },
      templateUrl: 'js/directives/data_map.html',
      link: function(scope, element, attr) {

        $timeout(function() {
          console.log('ddddddddd');
          cartodb.createVis('map', 
          'http://onlyjsmith.cartodb.com/api/v2/viz/e4f156dc-6da2-11e4-8c7b-0e853d047bba/viz.json');
        }, 500);
      }
    };
  }

  angular
    .module('App')
    .directive('mapD', mapD);

})();