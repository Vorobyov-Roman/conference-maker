'use strict'

angular.module('main').controller('ApplicationController', [
  'application',
  function(application) {

    this.application = application.data;

  }
]);
