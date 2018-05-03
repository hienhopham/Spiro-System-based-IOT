'use strict';

angular
  .module('MLServer')
  .run(['$http', 'Authentication', '$location',

  function ($http, Authentication, $location) {
    var currentURL = $location.path();

    $http.defaults.xsrfHeaderName = 'X-CSRFToken';
    $http.defaults.xsrfCookieName = 'csrftoken';

    if (Authentication.isAuthenticatedURL(currentURL) && !Authentication.isAuthenticated()) {
      $location.url('/');
    } else if (!Authentication.isAuthenticatedURL(currentURL) && Authentication.isAuthenticated()) {
      $location.url('/home');
    }

  }]);
