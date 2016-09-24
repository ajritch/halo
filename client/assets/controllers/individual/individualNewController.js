app.controller('individualNewController', ['$scope','individualsFactory', '$location', function($scope, individualsFactory, $location) {
/*
  OUR $scope.create function goes here <-- $scope because we need to access this method 
  with ng-submit or ng-click (from the form in the previous assignment).  
  Want to all of the individuals when we get back?  We can re-run index.
*/
    $scope.create = function(){
        individualsFactory.createIndividual($scope.individual, function(){
            $location.url("/individuals");
        });
    }
}]);