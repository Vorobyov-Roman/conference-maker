"use strict"

angular.module('main').controller('SignupController', [
  '$scope',
  'authentication',
  'responseResolver',
  function ($scope, authentication, responseResolver) {

    var self = this;
    var modal = $('#signup');

    this.submit = function() {
      function onSuccess(data) {
        self.message = null;

        modal.modal('hide');
      }

      function onError(err) {
        responseResolver
          .on('BAD_REQUEST', function() {
            $scope.$broadcast('FORCE_VALIDATION', err.data.errors);
          })
          .default(function() {
            self.message = "Request to the server failed.";
          });

        responseResolver.resolve(err.status);
      }

      authentication.signUp(this.data).then(onSuccess, onError);
    }

  }
]);
