'use strict';

angular.module('MLServer')
  .component('equation', {
    bindings: {
      targetValue: '@',
      onUpdate: '&'
    },
    controller: 'equationController',
    controllerAs: 'vm',
    templateUrl: '/static/templates/lung-function/charts/equation.html'
  });