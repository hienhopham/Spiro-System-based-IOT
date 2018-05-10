'use strict';

angular
  .module('MLServer.authentication')
  .controller('LoginController', LoginController);

LoginController.$inject = ['$location', '$scope', 'Authentication'];

function LoginController($location, $scope, Authentication) {
  
  var self = this;

  self.error = '';
  self.login = login;

  function login() {
    Authentication.login(self.username, self.password, loginErrorFn);

    function loginErrorFn() {
      self.error = 'Can not find the account!';
    }
  }
}
