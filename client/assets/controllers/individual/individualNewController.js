app.controller('individualNewController', ['$scope', 'userFactory', 'individualsFactory', '$location', '$base64', 
	function($scope, userFactory, individualsFactory, $location, $base64) {
    $scope.user = {};
    
    userFactory.getUser(function(data) {
      $scope.user = data;
      if (!$scope.user.username)
        $scope.user.username = "";
      else
        $scope.user.username = $scope.user.username;
    });

/*
  OUR $scope.create function goes here <-- $scope because we need to access this method 
  with ng-submit or ng-click (from the form in the previous assignment).  
  Want to all of the individuals when we get back?  We can re-run index.
*/
    $scope.addIndividual = function(){
        if ($scope.new_individual.image) {
    	      $scope.new_individual.image = $scope.new_individual.image.base64
            $scope.new_individual.subject_id=Math.random().toString(36).replace(/[^a-z]+/g, '').substr(0, 15);
        }
        individualsFactory.createIndividual($scope.new_individual, function(){
            $location.url("/individuals/index");
        });
    }
}]);
