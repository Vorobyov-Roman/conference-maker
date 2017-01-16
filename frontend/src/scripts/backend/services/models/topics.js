'use strict'

angular.module('backend').service('Topics', [
  'request',
  function(request) {

    this.all = function() {
      return request.get('topics');
    }

    this.get = function(id) {
      return request.get('topics/' + id);
    }

  }
]);
