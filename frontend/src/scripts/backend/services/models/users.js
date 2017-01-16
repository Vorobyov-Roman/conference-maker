'use strict'

angular.module('backend').service('Users', [
  'request',
  function(request) {

    this.all = function() {
      return request.get('users');
    }

    this.get = function(id) {
      return request.get('users/' + id);
    }

  }
]);
