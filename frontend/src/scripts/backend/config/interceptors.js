'use strict'

angular.module('backend').config([
  '$httpProvider',
  'jwtOptionsProvider',
  'BACKEND_ADDRESS',
  function($httpProvider, jwtOptionsProvider, BACKEND_ADDRESS) {

    jwtOptionsProvider.config({
      tokenGetter: [
        '$cookies',
        'AUTH_TOKEN',
        function($cookies, AUTH_TOKEN) {
          return $cookies.get(AUTH_TOKEN);
        }
      ],

      whiteListedDomains: [
        BACKEND_ADDRESS
      ]
    });

    $httpProvider.interceptors.push('jwtInterceptor');

  }
]);
