'use strict'

angular.module('backend').service('validation', [
  'request',
  function(request) {

    this.validate = function(model, data, field) {
      return request.post('validate/' + model, { data: data, field: field });
    }

  }
]);
