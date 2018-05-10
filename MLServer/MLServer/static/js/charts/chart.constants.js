'use strict';

angular.module('MLServer')
  .constant('CHARTS', {
    pef: {
      title: 'PEF Visualization',
      name: 'pef',
      idTab: 'PEF',
      idChart: 'PEFChart',
      postUrl: '/lung-function/api/get-dataset-pef',
      equationData: {
        target_value: 'pef',
        lower_bound: 48,
        higher_bound: 62,
        num: 200
      }
    },
    fef: {
      title: 'FEF Visualization',
      name: 'fef',
      idTab: 'FEF',
      idChart: 'FEFChart',
      postUrl: '/lung-function/api/get-dataset-fef',
      equationData: {
        target_value: 'fef',
        lower_bound: 25,
        higher_bound: 62,
        num: 200
      }
    },
    fvc: {
      title: 'FVC Visualization',
      name: 'fvc',
      idTab: 'FVC',
      idChart: 'FVCChart',
      postUrl: '/lung-function/api/get-dataset-fvc',
      equationData: {
        target_value: 'fvc',
        lower_bound: 2,
        higher_bound: 6,
        num: 200
      }
    },
    fev1: {
      title: 'FEV1 Visualization',
      name: 'fev1',
      idTab: 'FEV1',
      idChart: 'FEV1Chart',
      postUrl: '/lung-function/api/get-dataset-fev1',
      equationData: {
        target_value: 'fev1',        
        lower_bound: 2,
        higher_bound: 6,
        num: 200
      }
    }
  });