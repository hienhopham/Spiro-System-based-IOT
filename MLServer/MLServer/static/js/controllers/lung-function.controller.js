'use strict';

angular
  .module('MLServer')
  .controller('LungFunctionController', LungFunctionController);

LungFunctionController.$inject = ['$interval', '$document', 'CHARTS'];

function LungFunctionController($interval, $document, CHARTS) {

  var self = this;

  self.startProgress = startProgress;
  self.stopProgress = stopProgress;
  self.charts = CHARTS;

  function startProgress() {
    self.activated = true;
  }

  function stopProgress() {
    self.activated = false;
    $document[0].body.scrollTop = $document[0].documentElement.scrollTop = 10;
  }

}
