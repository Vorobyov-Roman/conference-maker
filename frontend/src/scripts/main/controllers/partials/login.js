"use strict"

angular.module('main').controller('LoginController', [
  '$scope',
  'authentication',
  'responseResolver',
  function ($scope, authentication, responseResolver) {

    var self = this;
    var modal = $('#login');

    this.submit = function() {
      function onSuccess(data) {
        this.message = null;

        modal.modal('hide');
      }

      function onError(err) {
        responseResolver
          .on('BAD_REQUEST', function() {
            self.message = "Invalid login or password.";
          })
          .default(function() {
            self.message = "Request to the server failed.";
          });

        responseResolver.resolve(err.status);
      }

      authentication.logIn(this.data).then(onSuccess, onError);
    }

  }
]);
