'use strict';


// Declare app level module which depends on filters, and services
angular.module('App', [
  'DataApp',
  'ngRoute',


])
.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/', {templateUrl: 'partials/partial1.html', controller: 'MainCtrl'});
  $routeProvider.otherwise({redirectTo: '/'});
}]);
