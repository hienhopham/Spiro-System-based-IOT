var app = angular.module('MLServerLogin', []);

app.controller('MLServerLoginController', function($scope, $http) {

  $scope.submit = submit;

  function submit() {
    user = {username: 'hienpham', password:'beutifulhien'};
    
    $http.post('/user/api/', user);
    console.log(user);
  }
});