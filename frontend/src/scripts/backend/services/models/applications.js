'use strict'

angular.module('backend').service('Applications', [
  'request',
  function(request) {

    this.all = function() {
      return request.get('applications');
    }

    this.get = function(id) {
      return request.get('applications/' + id);
    }

  }
]);
