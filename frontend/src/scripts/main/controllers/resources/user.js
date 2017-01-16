'use strict'

angular.module('main').controller('UserController', [
  'user',
  'authentication',
  function(user, authentication) {

    this.user = user.data;

    this.getHeader = function() {
      if (authentication.isLoggedIn()) {
        var currentUser = authentication.getCurrentUser();

        if (currentUser.id === this.user.id)
          return 'Hello, ' + this.user.name;
      }

      return this.user.name;
    }

  }
]);
