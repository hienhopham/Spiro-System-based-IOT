'use strict';

angular
  .module('MLServer')
  .factory('EquationService', EquationService);

  EquationService.$inject = ['$http'];

function EquationService($http) {

  var EquationService = {
    getLungEquation: getLungEquation
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

    paramsStr = paramsStr.substring(1, paramsStr.length-1);
    params = paramsStr.split(',');

    return params
  }

}