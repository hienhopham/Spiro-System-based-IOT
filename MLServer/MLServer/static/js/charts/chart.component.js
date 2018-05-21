'use strict';

angular.module('MLServer')
  .component('chart', {
    bindings: {
      chart: '<',
      startProgress: '&',
      stopProgress: '&'
    },
    controller: 'chartController',
    controllerAs: 'vm',
    templateUrl: '/static/templates/lung-function/charts/chart.html'
  });