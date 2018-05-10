'use strict';

angular
  .module('MLServer')
  .run(['$http', '$location', 'Authentication',

  function ($http, $location, Authentication) {
    var currentURL = $location.path();

    $http.defaults.xsrfHeaderName = 'X-CSRFToken';
    $http.defaults.xsrfCookieName = 'csrftoken';

    if (Authentication.isAuthenticatedURL(currentURL) && !Authentication.isAuthenticated()) {
      $location.url('/');
    } else if (!Authentication.isAuthenticatedURL(currentURL) && Authentication.isAuthenticated()) {
      $location.url('/home');
    }

  }]);
