'use strict'

angular.module('backend').service('validation', [
  'request',
  function(request) {

    this.validateUser = function(data, field) {
      return request.post('validate/user', { userdata: data, field: field });
    }

  }
]);
