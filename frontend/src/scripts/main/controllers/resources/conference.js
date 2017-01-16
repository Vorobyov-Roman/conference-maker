'use strict'

angular.module('main').controller('ConferenceController', [
  'conference',
  function(conference) {

    this.conference = conference.data;

    this.getAttendeesCount = function() {
      return this.conference.attendees.length;
    }

  }
]);
