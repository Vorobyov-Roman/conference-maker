'use strict'

angular.module('main').config([
  '$routeProvider',
  function($routeProvider) {

    $routeProvider
      .when('/', {
        templateUrl:  'views/home.html',
        controller:   'HomeController',
        controllerAs: 'ctrl',
        resolve: {
          conferences: ['Conferences', function(Conferences) {
            return Conferences.all();
          }]
        }
      })
      .when('/application/:id', {
        templateUrl:  'views/resources/application.html',
        controller:   'ApplicationController',
        controllerAs: 'ctrl',
        resolve: {
          application: ['$route', 'Applications', function($route, Applications) {
            return Applications.get($route.current.params.id);
          }]
        }
      })
      .when('/conference/:id', {
        templateUrl:  'views/resources/conference.html',
        controller:   'ConferenceController',
        controllerAs: 'ctrl',
        resolve: {
          conference: ['$route', 'Conferences', function($route, Conferences) {
            return Conferences.get($route.current.params.id);
          }]
        }
      })
      .when('/review/:id', {
        templateUrl:  'views/resources/review.html',
        controller:   'ReviewController',
        controllerAs: 'ctrl',
        resolve: {
          review: ['$route', 'Reviews', function($route, Reviews) {
            return Reviews.get($route.current.params.id);
          }]
        }
      })
      .when('/topic/:id', {
        templateUrl:  'views/resources/topic.html',
        controller:   'TopicController',
        controllerAs: 'ctrl',
        resolve: {
          topic: ['$route', 'Topics', function($route, Topics) {
            return Topics.get($route.current.params.id);
          }]
        }
      })
      .when('/user/:id', {
        templateUrl:  'views/resources/user.html',
        controller:   'UserController',
        controllerAs: 'ctrl',
        resolve: {
          user: ['$route', 'Users', function($route, Users) {
            return Users.get($route.current.params.id);
          }]
        }
      })
      .otherwise({
        redirectTo: '/'
      });

  }
]);
