'use strict'

angular.module('main').controller('SignupController', [
  '$scope',
  '$log',
  'authentication',
  'responseResolver',
  function($scope, $log, authentication, responseResolver) {

    var self = this;
    var modal = $('#signup');

    this.data = {};

    this.submit = function() {
      function onSuccess(response) {
        delete self.message;

        modal.modal('hide');
      }

      function onError(err) {
        responseResolver
          .on('BAD_REQUEST', function() {
            delete self.message;
            $scope.$broadcast('FORCE_VALIDATION', err.data.errors);
          })
          .default(function() {
            $log.error(err);

            self.message = "Request to the server failed.";
          });

        responseResolver.resolve(err.status);
      }

      authentication.signUp(this.data).then(onSuccess, onError);
    }

  }
]);
