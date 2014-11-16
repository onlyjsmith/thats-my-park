'use strict';

(function () {

  function tableD() {
    return {
      restrict: 'E',
      scope: {
        t: '=',
        tt: '=',
      },
      templateUrl: 'js/directives/data_table.html',
      link: function(scope, element, attr) {

        console.log('#####', scope);


        var el = element[0],
            width,
            height,
            data = {};

      scope.all = true;

      scope.t.then(function(d) {
        scope.data = d.data;
        scope.toggleTable();
      });

      scope.tt.then(function(d) {
        scope.dataOverlap = d.data;
      });

      
      

      scope.toggleTable = function() {
        if (scope.all) {
          scope.rows = scope.data.rows;
          scope.fieldList = d3.keys(scope.data.fields);
          scope.all = false;
        } else {
          scope.rows = scope.dataOverlap.rows;
          scope.fieldList = d3.keys(scope.dataOverlap.fields);
          scope.all = true;
        }
      }
        
      }
    };
  }

  angular
    .module('App')
    .directive('tableD', tableD);

})();