'use strict';

angular.module('MLServer')
  .constant('CHARTS', {
    pef: {
      name: 'pef',
      idTab: 'PEF',
      idChart: 'PEFChart'
    },
    fef: {
      name: 'fef',
      idTab: 'FEF',
      idChart: 'FEFChart'
    },
    fvc: {
      name: 'fvc',
      idTab: 'FVC',
      idChart: 'FVCChart'
    },
    fev1: {
      name: 'fev1',
      idTab: 'FEV1',
      idChart: 'FEV1Chart'
    }
  });