'use strict';

angular
  .module('MLServer')
  .controller('HomeController', HomeController);

HomeController.$inject = ['$scope', '$location', 'Authentication'];

function HomeController($scope, $location, Authentication) {
  
  var self = this;

  self.$onInit = $onInit;
  self.logout = logout;

  function $onInit() {

    if(!Authentication.isAuthenticated()) {
      $location.url('/');
    }
  }

  function logout() {
    Authentication.logout();
  }

}
