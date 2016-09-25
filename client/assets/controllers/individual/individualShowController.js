app.controller('individualShowController', ['$scope', 'userFactory', 'individualsFactory', '$location', '$routeParams', '$base64',
	function($scope, userFactory, individualsFactory, $location, routeParams, $base64) {
    $scope.user = {};
    
    userFactory.getUser(function(data) {
      $scope.user = data;
      if (!$scope.user.username)
        $scope.user.username = "";
      else {
        $scope.user.username = $scope.user.username;
        $scope.comma = ", ";
      }
    });

    $scope.show = function(){
        individualsFactory.getOneIndividual(routeParams.id, function(data){
            $scope.individual = data.result;
        });
    };
    $scope.show();
/*
  OUR $scope.create function goes here <-- $scope because we need to access this method 
  with ng-submit or ng-click (from the form in the previous assignment).  
  Want to all of the individuals when we get back?  We can re-run index.
*/
  
}]);