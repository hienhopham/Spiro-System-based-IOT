'use strict';

angular
  .module('MLServer')
  .controller('LungFunctionController', LungFunctionController);

HomeController.$inject = ['CHARTS'];

function LungFunctionController(CHARTS) {

  var self = this;

  self.charts = CHARTS;

}
