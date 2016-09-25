var app = angular.module('app', ['ngRoute']);
app.config(function ($routeProvider) {
// Routes to load your new and edit pages with new and edit controllers attached to them!
    $routeProvider
    
    .when('/', {
        templateUrl: '/partials/login.html',
        controller: 'loginController'
    })
    .when('/individuals/index', {
        templateUrl: '/partials/index_individual.html',
        controller: 'individualIndexController'
    })
    .when('/individuals/:id/edit', {
        templateUrl: '/partials/edit_individual.html',
        controller: 'individualEditController',
    })
    .when('/individuals/new', {
        templateUrl: '/partials/new_individual.html',
        controller: 'individualNewController',
    })
    .when('/individuals/:id', {
        templateUrl: '/partials/show_individual.html',
        controller: 'individualShowController',
    })
    .otherwise({
        redirectTo: '/'
    });
});