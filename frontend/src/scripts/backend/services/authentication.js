"use strict"

angular.module('backend').service('authentication', [
  '$q',
  '$cookies',
  'request',
  function($q, $cookies, request) {

    this.logIn = function(data) {
      return $q(function(resolve, reject) {
        function onSuccess(data) {
          $cookies.put('auth-token', data.data.token);

          resolve(data);
        }

        function onError(err) {
          reject(err);
        }

        request.post('login', { userdata: data }).then(onSuccess, onError);
      });
    }

    this.logOut = function() {
      $cookies.remove('auth-token');
    }

    this.isLoggedIn = function() {
      return $cookies.get('auth-token') !== undefined;
    }

    this.signUp = function(data) {
      return request.post('register', { userdata: data });
    }

  }
]);
