'use strict'

angular.module('main').controller('TopicController', [
  'topic',
  function(topic) {

    this.topic = topic.data;

  }
]);
