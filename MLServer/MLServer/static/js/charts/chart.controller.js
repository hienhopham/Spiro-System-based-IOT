'use strict';

angular
  .module('MLServer')
  .controller('chartController', chartController);

chartController.$inject = ['$q', '$scope', '$timeout', 'ChartService', 'CHARTS'];
function chartController($q, $scope, $timeout, ChartService, CHARTS) {
  var regressData, scatterData;
  var self = this;

  self.$onInit = $onInit;

  var getScatterData = function () {
    var deferred = $q.defer();

    ChartService.getDataset(self.chart.postUrl, function (err, data) {
      if (err) {
        deferred.reject(err);
      }
      deferred.resolve(data);
    });

    return deferred.promise;
  }

  var getRegressData = function () {
    var deferred = $q.defer();

    ChartService.getDataset('/lung_function/api/get_data_eq_visual', function (err, data) {
      if (err) {
        deferred.reject(err);
      }
      deferred.resolve(data);
    }, self.chart.equationData);

    return deferred.promise;
  }

  function $onInit() {

    $q.all([getScatterData(), getRegressData()]).then(function (data) {
      buildChart(self.chart.idChart, data[0], data[1]);
    });
  }

  function buildChart(idChart, scatterData, regressData) {

    $timeout(function () {
      Highcharts.chart(idChart, {
        xAxis: {
          title: {
            text: 'Input value'
          },
          min: self.chart.equationData.lower_bound,
          max: self.chart.equationData.higher_bound
        },
        yAxis: {
          title: {
            text: 'Output value'
          },
          min: 0
        },
        title: {
          text: self.chart.title
        },
        legend: {
          layout: 'vertical',
          align: 'right',
          verticalAlign: 'middle'
        },
        series: [{
          type: 'line',
          name: 'Regression Line',
          data: regressData,
          marker: {
            enabled: false
          },
          states: {
            hover: {
              lineWidth: 5
            }
          },
          enableMouseTracking: false
        }, {
          type: 'scatter',
          name: 'Real values',
          data: scatterData
        }],
        responsive: {
          rules: [{
            condition: {
              maxWidth: 500
            },
            chartOptions: {
              legend: {
                layout: 'horizontal',
                align: 'center',
                verticalAlign: 'bottom'
              }
            }
          }]
        }
      });

    });
  }

}