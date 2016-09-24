var app = angular.module('app', ['ngRoute']);
app.config(function ($routeProvider) {
// Routes to load your new and edit pages with new and edit controllers attached to them!
    $routeProvider
    
    .when('/', {
        templateUrl: '/partials/index.html',
        controller: 'individualIndexController'
    })
    .when('/individuals/:id/edit', {
        templateUrl: '/partials/edit.html',
        controller: 'individualEditController',
    })
    .when('/individuals/new', {
        templateUrl: '/partials/new.html',
        controller: 'individualNewController',
    })
    .when('/individuals/:id', {
        templateUrl: '/partials/show.html',
        controller: 'individualShowController',
    })
    .otherwise({
        redirectTo: '/'
    });
});