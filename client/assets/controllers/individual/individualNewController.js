app.controller('individualNewController', ['$scope','individualsFactory', '$location', '$base64', 
	function($scope, individualsFactory, $location, $base64) {
/*
  OUR $scope.create function goes here <-- $scope because we need to access this method 
  with ng-submit or ng-click (from the form in the previous assignment).  
  Want to all of the individuals when we get back?  We can re-run index.
*/
    $scope.addIndividual = function(){
    	console.log($scope.new_individual.image)
        individualsFactory.createIndividual($scope.new_individual, function(){
            $location.url("/individuals");
        });
    }
}]);