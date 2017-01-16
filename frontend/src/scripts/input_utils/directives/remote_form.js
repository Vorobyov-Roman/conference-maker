'use strict'

angular.module('inputUtils').directive('remoteForm', [
  function() {

    function ctrl($scope, validation) {

      var data = angular.copy($scope.data());

      this.validate = function(field, value) {
        data[field] = value;

        return validation.validate($scope.target, data, field);
      }

    }

    return {
      scope: {
        data:   '&remoteForm',
        target: '@remoteFormFor'
      },
      controller: ['$scope', 'validation', ctrl]
    }

  }
]);
