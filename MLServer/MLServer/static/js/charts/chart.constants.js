'use strict';

angular.module('MLServer')
  .constant('CHARTS', {
    pef: {
      title: 'PEF Visualization',
      idTab: 'PEF',
      idChart: 'PEFChart',
      postUrl: '/lung_function/api/get_dataset_pef',
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
      postUrl: '/lung_function/api/get_dataset_fef',
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
      postUrl: '/lung_function/api/get_dataset_fvc',
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
      postUrl: '/lung_function/api/get_dataset_fev1',
      equationData: {
        target_value: 'fev1',        
        lower_bound: 2,
        higher_bound: 6,
        num: 200
      }
    }
  });