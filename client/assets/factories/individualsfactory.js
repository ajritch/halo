console.log("Individuals Factory");
app.factory('individualsFactory', ['$http', function($http){
    var factory = {};
    var individuals = [];
    var individual = [];

    factory.getAllIndividuals = function(callback){
        $http.get("/individuals").then(function(data){
            console.log(data);
            individuals = data.data;
            callback(individuals);
        });
    }

    factory.getOneIndividual = function(id, callback){
        console.log(id);
        $http.get("/individuals/"+id).then(function(data){
            console.log(data);
            individuals = data.data;
            callback(individuals);
        });
    }

    factory.createIndividual = function(newIndividual, callback){
        $http.post("/individuals", newIndividual).then(function(returned_data){
            console.log(returned_data);
            if(typeof(callback) == 'function'){
                callback(returned_data.data);
            }
        });
    };
    factory.updateIndividual = function(id, updatedIndividual, callback){
        console.log(id);
        $http.put("/individuals/"+id, updatedIndividual).then(function(returned_data){
            console.log(returned_data);
            if(typeof(callback) == 'function'){
                callback(returned_data.data);
            }
        });
    }
    factory.deleteIndividual = function(id, callback){
        console.log(id);
        $http.delete("/individuals/"+id).then(function(){
            if(typeof(callback) == 'function'){
                callback();
            }
        });
    }



    return factory;
}]);