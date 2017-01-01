'use strict'

angular.module('inputUtils').directive('remoteForm', [
  function() {

    function ctrl($scope, validation) {

      var data = angular.copy($scope.data());

      this.validate = function(field, value) {
        data[field] = value;

        return validation.validateUser(data, field);
      }

    }

    return {
      scope: {
        data: '&remoteForm'
      },
      controller: ['$scope', 'validation', ctrl]
    }

  }
]);
