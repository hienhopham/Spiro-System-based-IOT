'use strict';

angular
  .module('MLServer')
  .controller('equationController', equationController);

equationController.$inject = ['$q', '$scope', '$timeout', 'EquationService'];
function equationController($q, $scope, $timeout, EquationService) {
  var self = this;

  self.equation = {};
  self.$onInit = $onInit;
  self.train = train;

  function $onInit() {
    EquationService.getLungEquation('/lung-function/api/lung-equation', function (err, data) {
      if (err) {
        console.log(err);
      }
      self.equation = data;
      self.new_learning_rate = data.learning_rate;
    }, { target_value: self.targetValue });
  }

  function train() {
    console.log(self.new_learning_rate);
    self.onUpdate({learningRate:self.new_learning_rate});
  }

}