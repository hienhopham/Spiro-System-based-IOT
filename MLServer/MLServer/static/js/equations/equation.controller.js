'use strict';

angular
  .module('MLServer')
  .controller('equationController', equationController);

equationController.$inject = ['$q', '$scope', '$timeout', 'EquationService', ];
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
      self.iterations = data.iterations;
      self.ms_error = data.ms_error;
      self.test_err = data.test_err;
      self.params = data.params;
    }, { target_value: self.chart.equationData.target_value });
  }

  function train() {
    self.startProgress();

    var data = {
      new_learning_rate: self.new_learning_rate ,
      new_iterations: self.iterations,
      lower_bound: self.chart.equationData.lower_bound,
      higher_bound: self.chart.equationData.higher_bound,
      num: self.chart.equationData.num
    };
    EquationService.getNewLungEquation('/lung-function/api/get-new-model-' + self.chart.equationData.target_value, function (err, data) {
      if (err) {
        console.log(err);
      }
      if(data.error) {
        self.error = data.error;
      } else {
        self.ms_error = data.mse;
        self.test_err = data.test_err;
        self.params  = data.params;
        self.onUpdate({ regressData: data.regressData });
        self.stopProgress();
      }
    }, data);
  }

}