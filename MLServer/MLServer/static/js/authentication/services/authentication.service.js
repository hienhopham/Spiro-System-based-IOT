'use strict';

angular
  .module('MLServer.authentication')
  .factory('Authentication', Authentication);

Authentication.$inject = ['$http', '$cookies'];

function Authentication($http, $cookies) {

  var Authentication = {
    register: register,
    login: login,
    logout: logout,
    getAuthenticatedAccount: getAuthenticatedAccount,
    isAuthenticated: isAuthenticated,
    setAuthenticatedAccount: setAuthenticatedAccount,
    unauthenticate: unauthenticate,
    isAuthenticatedURL: isAuthenticatedURL
  };

  return Authentication;

  function register(email, password, username) {
    return $http.post('/api/v1/accounts/', {
      username: username,
      password: password,
      email: email
    }).then(registerSuccessFn, registerErrorFn);

    function registerSuccessFn(data, status, headers, config) {
      Authentication.login(username, password);
    }

    function registerErrorFn(data, status, headers, config) {
      console.error('Epic failure!');
    }
  }

  function login(username, password, loginErrorFn) {
    return $http.post('/api/v1/auth/login/', {
      username: username, password: password
    }).then(loginSuccessFn, loginErrorFn);
  
    function loginSuccessFn(data, status, headers, config) {
      Authentication.setAuthenticatedAccount(data.data);
  
      window.location = '/home';
    }

  }

  function logout() {

    return $http.post('/api/v1/auth/logout/')
      .then(logoutSuccessFn, logoutErrorFn);
  
    function logoutSuccessFn(data, status, headers, config) {
      Authentication.unauthenticate();
      window.location = '/';
    }
  
    function logoutErrorFn(data, status, headers, config) {
      console.error('Epic failure!');
    }
  }

  function getAuthenticatedAccount() {
    if (!$cookies.getObject('globals')) {
      return;
    }
  
    return $cookies.getObject('globals');
  }

  function isAuthenticated() {

    return $cookies.getObject('globals') ? true : false;
  }

  function setAuthenticatedAccount(account) {
    var cookieExp = new Date();
    cookieExp.setDate(cookieExp.getDate() + 7);
    $cookies.putObject('globals', account, { expires: cookieExp });
  }

  function unauthenticate() {
    $cookies.remove('globals');
  }

  function isAuthenticatedURL(url) {
    var allow_url = ['/', '/login/', '/register'];

    if(allow_url.indexOf(url) == -1) {
      return true;
    }

    return false;
  }
}
