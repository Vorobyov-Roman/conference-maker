'use strict'

angular.module('main').controller('NewConferenceController', [
  '$scope',
  '$log',
  'Conferences',
  'responseResolver',
  function($scope, $log, Conferences, responseResolver) {

    var self = this;
    var modal = $('#new-conference');

    this.data = {};

    this.submit = function() {
      function onSuccess(response) {
        delete self.message;

        $scope.$emit('CONFERENCES_CHANGED');

        modal.modal('hide');
      }

      function onError(err) {
        responseResolver
          .on('BAD_REQUEST', function() {
            delete self.message;
            $scope.$broadcast('FORCE_VALIDATION', err.data.errors);
          })
          .on('UNAUTHORIZED', function() {
            $log.error(err);

            self.message = "Unauthorized request.";
          })
          .default(function() {
            $log.error(err);

            self.message = "Request to the server failed.";
          });

        responseResolver.resolve(err.status);
      }

      Conferences.create(this.data).then(onSuccess, onError);
    }

  }
]);
