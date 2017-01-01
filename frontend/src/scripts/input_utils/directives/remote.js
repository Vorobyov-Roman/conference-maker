'use strict'

angular.module('inputUtils').directive('remote', [
  '$q',
  'validation',
  'async',
  function($q, validation, async) {

    function link(scope, elem, attrs, ctrls) {

      var anyPendingRequests = false;

      var formCtrl  = ctrls[0];
      var inputCtrl = ctrls[1];

      scope.$on('FORCE_VALIDATION', function(event, args) {
        inputCtrl.setMessages(args[scope.field]);
        inputCtrl.$setDirty();
      });

      function sendRequest(value, def) {
        function onSuccess(response) {
          var errors = response.data.errors;

          inputCtrl.setMessages(errors);

          errors.length > 0 ? def.reject() : def.resolve();
        }

        function onError(err) {
          def.reject();
        }

        formCtrl.validate(scope.field, value).then(onSuccess, onError);
      }

      inputCtrl.getMessages = function() {
        return this.messages || [];
      }

      inputCtrl.setMessages = function(messages) {
        this.messages = messages;
      }

      inputCtrl.hasMessages = function() {
        return this.getMessages().length > 0;
      }

      inputCtrl.valid = function() {
        return !anyPendingRequests && this.$dirty && !this.hasMessages();
      }

      inputCtrl.invalid = function() {
        return !anyPendingRequests && this.$dirty && this.hasMessages();
      }

      inputCtrl.$asyncValidators.remote = function(modelValue, viewValue) {
        if (inputCtrl.$pristine) {
          return $q.resolve();
        }

        return async.execute(function(def) {
          function onSuccess(data) {
            anyPendingRequests = false;
            def.resolve();
          }

          function onError(err) {
            // treat unprocessed requests as as pending
            def.reject();
          }

          anyPendingRequests = true;

          async.execute(sendRequest.bind(null, modelValue))
            .then(onSuccess, onError);
        });
      }

    }

    return {
      require: ['^^remoteForm', 'ngModel'],
      scope: {
        field: '@remote'
      },
      link: link
    }

  }
]);
