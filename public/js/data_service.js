(function () {
  "use strict";

  angular.module("DataApp", [])
  .service('DataService', function($http) {

    this.init = function(conf) {
      console.log('dddddddddddd');
      this.query = 'select%20name,%20created_at%20from%20thats_my_farm';
      this.resourceUrl = 'http://onlyjsmith.cartodb.com/api/v2/sql/?q='+this.query;
    };


    this.getTableData = function() {

      //return $http.get(this.url);
      return $http.get('http://onlyjsmith.cartodb.com/api/v2/sql/?q=select%20name,%20created_at%20from%20thats_my_farm');
    };


    this.getOverlapTableData = function() {
      //return $http.get(this.url);
      return $http.get('http://onlyjsmith.cartodb.com/api/v2/sql/?q=SELECT%20p1.name%20as%20name1,p2.name%20as%20name2%20FROM%20thats_my_farm%20p1,%20thats_my_farm%20p2%20WHERE%20ST_Intersects(p1.the_geom,%20p2.the_geom) and p1.name != p2.name');
    };



  });

}());
