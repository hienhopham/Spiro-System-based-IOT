'use strict';

angular
  .module('MLServer')
  .config(['$stateProvider', '$locationProvider', '$urlRouterProvider',
    function ($stateProvider, $locationProvider, $urlRouterProvider) {

      $stateProvider
        .state('register', {
          url:'/register',
          controller: 'RegisterController',
          controllerAs: 'vm',
          templateUrl: '/static/templates/authentication/register.html'
        })
        .state('login', {
          url:'/',
          controller: 'LoginController',
          controllerAs: 'vm',
          templateUrl: '/static/templates/authentication/login.html'
        })
        .state('home', {
          url:'/home',
          controller: 'HomeController',
          controllerAs: 'vm',
          templateUrl: '/static/templates/home.html'
        })
        .state('home.lung', {
          url:'/lung-function',
          controller: 'LungFunctionController',
          controllerAs: 'vm',
          templateUrl: '/static/templates/lung-function/lung-function.html'
        });

      $urlRouterProvider.otherwise('/home');

      $locationProvider.html5Mode(true);
      $locationProvider.hashPrefix('');
    }]);
