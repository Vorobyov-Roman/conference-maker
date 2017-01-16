'use strict'

angular.module('main').controller('NavbarController', [
  '$location',
  'authentication',
  function($location, authentication) {

    this.logOut = function() {
      return authentication.logOut();
    }

    this.isLoggedIn = function() {
      return authentication.isLoggedIn();
    }

    this.goToProfile = function() {
      var currentUser = authentication.getCurrentUser();
      console.log(currentUser);
      $location.path('/user/' + currentUser.id);
    }

  }
]);
