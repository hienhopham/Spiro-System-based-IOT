'use strict';

angular.module('MLServer')
  .component('chart', {
    bindings: {
      chart: '<'
    },
    controller: 'chartController',
    controllerAs: 'vm',
    templateUrl: '/static/templates/lung-function/charts/chart.html'
  });