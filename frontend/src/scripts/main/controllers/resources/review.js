'use strict'

angular.module('main').controller('ReviewController', [
  'review',
  function(review) {

    this.review = review.data;

  }
]);
