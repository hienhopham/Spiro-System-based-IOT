'use strict';

angular
  .module('MLServer')
  .factory('EquationService', EquationService);

EquationService.$inject = ['$http'];

function EquationService($http) {

  var EquationService = {
    getLungEquation: getLungEquation,
    getNewLungEquation: getNewLungEquation
  };
  return EquationService;

  function getLungEquation(url, callback, data) {
    $http.post(url, data).then(successFn, errorFn);

    function successFn(data, status, headers, config) {
      data.data.params = convertParams(data.data.params);
      callback(null, data.data);
    }

    function errorFn(data, status, headers, config) {
      callback('Failure!');
      return;
    }
  }

  function convertParams(paramsStr) {
    var params;

    paramsStr = paramsStr.substring(1, paramsStr.length - 1);
    params = paramsStr.split(',');

    return params
  }

  function getNewLungEquation(url, callback, data) {
    $http.post(url, data).then(successFn, errorFn);

    function successFn(data, status, headers, config) {
      if(!data.data.error) {
        data.data.regressData = convertData(data.data.regressData);
      }
      
      callback(null, data.data);
    }

    function errorFn(data, status, headers, config) {
      callback('Failure!');
      return;
    }
  }

  function convertData(dataset) {
    var chartData = [];
    var length = dataset.length;

    dataset.forEach(function (row) {
      chartData.push([row.input_value, row.output_value]);
    });

    return chartData;
  }

}