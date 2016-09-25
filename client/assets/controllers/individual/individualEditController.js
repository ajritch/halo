app.controller('individualEditController', ['$scope','individualsFactory', '$location', '$routeParams', function($scope, individualsFactory, $location, routeParams) {

    $scope.update = function(){
        individualsFactory.updateIndividual(routeParams.id, $scope.individual, function(data){
            $scope.individuals = data;
        });
    };
    individualsFactory.getOneIndividual(routeParams.id, function(data){
    	
        data.birthday = new Date(data.birthday);
		$scope.individual = data;
	});
/*
  OUR $scope.create function goes here <-- $scope because we need to access this method 
  with ng-submit or ng-click (from the form in the previous assignment).  
  Want to all of the individuals when we get back?  We can re-run index.
*/
  
}]);