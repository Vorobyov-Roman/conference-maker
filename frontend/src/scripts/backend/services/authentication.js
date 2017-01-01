'use strict'

angular.module('backend').service('authentication', [
  '$q',
  '$cookies',
  'request',
  'AUTH_TOKEN',
  function($q, $cookies, request, AUTH_TOKEN) {

    this.logIn = function(data) {
      return $q(function(resolve, reject) {
        function onSuccess(data) {
          $cookies.put(AUTH_TOKEN, data.data.token);

          resolve(data);
        }

        function onError(err) {
          reject(err);
        }

        request.post('login', { userdata: data }).then(onSuccess, onError);
      });
    }

    this.logOut = function() {
      $cookies.remove(AUTH_TOKEN);
    }

    this.isLoggedIn = function() {
      return $cookies.get(AUTH_TOKEN) !== undefined;
    }

    this.signUp = function(data) {
      return request.post('register', { userdata: data });
    }

  }
]);
