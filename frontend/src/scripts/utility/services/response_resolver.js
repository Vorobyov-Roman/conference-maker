'use strict'

angular.module('utility').service('responseResolver', [
  'HTTP_STATUSES',
  function(statuses) {

    this.map     = {}
    this.default = angular.noop;

    this.on = function(status, callback) {
      this.map[statuses[status]] = callback;
      return this;
    }

    this.default = function(callback) {
      this.default = callback;
      return this;
    }

    this.resolve = function(status) {
      (this.map[status] || this.default)();
    }

  }
]);
