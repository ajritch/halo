app.controller('individualIndexController', ['$scope','individualsFactory', '$location', function($scope, individualsFactory, $location) {
/*
  THIS INDEX METHOD ACCESSES THE IndividualS FACTORY AND RUNS THE IndividualS INDEX.
  WE MIGHT RE USE INDEX A FEW TIMES, SO TO MINIMIZE REPETITION WE SET IT AS A VARIABLE.
*/
    $scope.index = function(){
        individualsFactory.getAllIndividuals(function(returnedData){
            $scope.individuals = returnedData;
            console.log($scope.individuals);
        });
    };
    $scope.delete = function(individual_id){
        individualsFactory.deleteIndividual(individual_id, function(){
          console.log("individual deleted");
        });
        $scope.index();
    };
    $scope.index();
/*
  OUR $scope.create function goes here <-- $scope because we need to access this method 
  with ng-submit or ng-click (from the form in the previous assignment).  
  Want to all of the individuals when we get back?  We can re-run index.
*/
  
}]);