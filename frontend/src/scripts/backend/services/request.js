"use strict"

angular.module('backend').service('request', [
  '$http',
  'BACKEND',
  function($http, BACKEND) {

    this.get = function(path) {
      return $http.get(BACKEND + '/' + path);
    }

    this.post = function(path, data) {
      return $http.post(BACKEND + '/' + path, data);
    }

  }
]);
