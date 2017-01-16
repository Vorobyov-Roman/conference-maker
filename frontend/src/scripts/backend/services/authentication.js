'use strict'

angular.module('backend').service('authentication', [
  '$q',
  '$cookies',
  'jwtHelper',
  'request',
  'AUTH_TOKEN',
  function($q, $cookies, jwtHelper, request, AUTH_TOKEN) {

    this.logIn = function(data) {
      return $q(function(resolve, reject) {
        function onSuccess(response) {
          $cookies.put(AUTH_TOKEN, response.data.token);

          resolve(response);
        }

        function onError(err) {
          reject(err);
        }

        request.post('login', { data: data }).then(onSuccess, onError);
      });
    }

    this.logOut = function() {
      $cookies.remove(AUTH_TOKEN);
    }

    this.isLoggedIn = function() {
      return $cookies.get(AUTH_TOKEN) !== undefined;
    }

    this.signUp = function(data) {
      return request.post('register', { data: data });
    }

    this.getCurrentUser = function() {
      var token = $cookies.get(AUTH_TOKEN);

      return jwtHelper.decodeToken(token);
    }

  }
]);
