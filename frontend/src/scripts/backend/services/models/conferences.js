'use strict'

angular.module('backend').service('Conferences', [
  'request',
  function(request) {

    this.all = function() {
      return request.get('conferences');
    }

    this.get = function(id) {
      return request.get('conferences/' + id);
    }

    this.create = function(data) {
      return request.post('conferences', { data: data });
    }

  }
]);
