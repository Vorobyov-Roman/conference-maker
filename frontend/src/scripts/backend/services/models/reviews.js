'use strict'

angular.module('backend').service('Reviews', [
  'request',
  function(request) {

    this.all = function() {
      return request.get('reviews');
    }

    this.get = function(id) {
      return request.get('reviews/' + id);
    }

  }
]);
