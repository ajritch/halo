app.controller('loginController', ['$scope', '$location', 'userFactory', function($scope, $location, userFactory){
    $scope.user = {};

    $scope.login = function() {
        userFactory.setUser($scope.user, function(data) {
            $scope.user = data;
            if ($scope.user.username && $scope.user.username.length > 1)
                $location.path('/individuals/index')
        });
    }
}]);