app.factory('userFactory', function($http){
    var _user = {}  //the logged in user
    var factory = {}

    factory.getUser = function(callback) {
        //console.log("retrieving user:", _user);
        callback(_user);
    }

    factory.setUser = function(user, callback){
        console.log("setting user:", user);
        _user = user;
        callback(_user);
        // $http.post('/users', user).then(function(data){
        //     if (data.data.error){
        //         callback(data.data);
        //     } 
        //     else {
        //         _users.push(data.data.user);
        //         _user = data.data.user;  // this new user is now "logged in"
        //         callback(_users);
        //     }
        // })
    }

    return factory;
})