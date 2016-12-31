"use strict"

angular.module('main').config([
  '$routeProvider',
  function ($routeProvider) {

    $routeProvider
      .when('/', {
        templateUrl: 'views/home.html',
        controller: 'HomeController',
        controllerAs: 'ctrl'
      })
      .otherwise({
        redirectTo: '/'
      });

  }
]);
