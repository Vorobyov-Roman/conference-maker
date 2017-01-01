'use strict'

angular.module('main').controller('NavbarController', [
  'authentication',
  function(authentication) {

    this.logOut = function() {
      return authentication.logOut();
    }

    this.isLoggedIn = function() {
      return authentication.isLoggedIn();
    }

    this.goToProfile = function() {
    }

  }
]);
