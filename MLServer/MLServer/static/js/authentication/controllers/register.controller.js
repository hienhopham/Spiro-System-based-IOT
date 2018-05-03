'use strict';

angular
  .module('MLServer.authentication')
  .controller('RegisterController', ['$location', '$scope', 'Authentication',

  function ($location, $scope, Authentication) {
    var self = this;

    self.register = register;
    
    function register() {
      Authentication.register(self.email, self.password, self.username);
    }
  }]);
