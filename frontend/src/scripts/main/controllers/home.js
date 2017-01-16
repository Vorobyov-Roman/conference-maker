'use strict'

angular.module('main').controller('HomeController', [
  '$rootScope',
  '$location',
  'conferences',
  'Conferences',
  function($rootScope, $location, conferences, Conferences) {

    var self = this;

    this.conferences = conferences.data;

    $rootScope.$on('CONFERENCES_CHANGED', function() {
      Conferences.all().then(function(response) {
        self.conferences = response.data;
      });
    });

    this.goToConference = function(id) {
      $location.path('/conference/' + id);
    }

  }
]);
