'use strict';

angular
  .module('MLServer')
  .controller('chartController', chartController);

chartController.$inject = ['$q', '$scope', '$timeout', 'ChartService', 'CHARTS'];
function chartController($q, $scope, $timeout, ChartService, CHARTS) {
  var regressData, scatterData;
  var self = this;

  self.$onInit = $onInit;
  self.updateChart = updateChart;

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

    ChartService.getDataset('/lung-function/api/get-data-eq-visual', function (err, data) {
      if (err) {
        deferred.reject(err);
      }
      deferred.resolve(data);
    }, self.chart.equationData);

    return deferred.promise;
  }

  function $onInit() {

    $q.all([getScatterData(), getRegressData()]).then(function (data) {

      self.scatterData = data[0];
      buildChart(self.chart.idChart, data[0].trainedData, data[0].chartData, data[1].chartData);
    });
  }

  function updateChart(regressData) {

    buildChart(self.chart.idChart, self.scatterData.trainedData, self.scatterData.chartData, regressData);
  }

  function buildChart(idChart, scatterTrainedData, scatterTestData, regressData) {

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
        subtitle: {
          text: 'y = w*x^2 + u*x + b'
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
          name: 'Trained',
          color: 'rgba(119, 152, 191)',
          data: scatterTrainedData
        },
        {
          type: 'scatter',
          name: 'Test',
          color: 'rgba(223, 83, 83, .7)',
          data: scatterTestData
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