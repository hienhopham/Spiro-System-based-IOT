'use strict';

angular.module('MLServer')
  .component('equation', {
    bindings: {
      chart: '<',
      onUpdate: '&',
      startProgress: '&',
      stopProgress: '&'
    },
    controller: 'equationController',
    controllerAs: 'vm',
    templateUrl: '/static/templates/lung-function/charts/equation.html'
  });