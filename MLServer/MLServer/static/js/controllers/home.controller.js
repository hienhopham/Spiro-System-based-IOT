'use strict';

angular
  .module('MLServer')
  .controller('HomeController', HomeController);

HomeController.$inject = ['$scope', 'Authentication'];

function HomeController($scope, Authentication) {
  
  var self = this;

  self.logout = logout;

  function logout() {
    Authentication.logout();
  }

}
