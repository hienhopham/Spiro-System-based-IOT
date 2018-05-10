'use strict';

angular
  .module('MLServer')
  .factory('ChartService', ChartService);

ChartService.$inject = ['$http'];

function ChartService($http) {

  var ChartService = {
    getDataset: getDataset,
    convertData: convertData
  };
  return ChartService;

  function getDataset(url, callback, data) {
    $http.post(url, data).then(successFn, errorFn);

    function successFn(data, status, headers, config) {
      callback(null, convertData(data.data));
    }

    function errorFn(data, status, headers, config) {
      callback('Failure!');
      return;
    }
  }

  function convertData(dataset) {
    var chartData = [];
    var trainedData = [];
    var length = dataset.length;

    dataset.forEach(function (row) {
      if (row.trained) {
        trainedData.push([row.input_value, row.output_value]);
      } else {
        chartData.push([row.input_value, row.output_value]);
      }
    });

    return {
      chartData: chartData,
      trainedData: trainedData
    };
  }

}