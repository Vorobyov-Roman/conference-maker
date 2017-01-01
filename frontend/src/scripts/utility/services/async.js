'use strict'

angular.module('utility').service('async', [
  '$q',
  function($q) {

    this.execute = function(callback) {
      var def = $q.defer();

      callback(def);

      return def.promise;
    }

  }
]);
