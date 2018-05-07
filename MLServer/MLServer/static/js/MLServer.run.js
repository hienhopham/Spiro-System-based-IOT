'use strict';

angular
  .module('MLServer')
  .run(['$http', '$location', 'Authentication',

  function ($http, $location, Authentication) {
    var currentURL = $location.path();

    $http.defaults.xsrfHeaderName = 'X-CSRFToken';
    $http.defaults.xsrfCookieName = 'csrftoken';
    // console.log(Authentication.isAuthenticatedURL(currentURL));
    // console.log(currentURL);
    // console.log(Authentication.isAuthenticated());

    if (Authentication.isAuthenticatedURL(currentURL) && !Authentication.isAuthenticated()) {
      $location.url('/');
    } else if (!Authentication.isAuthenticatedURL(currentURL) && Authentication.isAuthenticated()) {
      $location.url('/home');
    }

  }]);
