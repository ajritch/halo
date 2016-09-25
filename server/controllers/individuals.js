console.log("server individuals controller");

var mongoose = require('mongoose');
var Individual = mongoose.model('Individual');

function Controller() {
  /* get all results for individuals */
  this.index = function(req, res) {
    console.log("server individual index");
    Individual.find({}, function(err, results) {
      if (err) {
        console.log("error finding results");
        res.json({ status: false, result: err });
      } else {
        console.log("found results", results);
        res.json({ status: true, result: results });
      }
    });
  };
  /* add one individual */
  this.create = function(req, res) {
    req.body.date_of_birth = new Date(req.body.date_of_birth);
    console.log("server individual create body: ", req.body);
    var result = new Individual(req.body);
    result.save(function(err) {
      if (err) {
        res.json({ status: false, result: err });
      } else {
        res.json({ status: true, result: result });
      }
    });
  };
  /* get info for one individual */
  this.show = function(req, res) {
    console.log("server individuals show", req.params);
    Individual.findOne({ _id: req.params.id }, function(err, result) {
      if (err) {
        res.json({ status: false, result: err });
      } else {
        res.json({ status: true, result: result });
      }
    });
  };
  /* get info for individual by Kairos ID */
  this.getById = function(req, res) {
    console.log("server show individual by face API ID", req.params);
    Individual.findOne({subject_id: req.params.subject_id}, function(err, individual) {
      if (err) {
        res.json({status: false, result: err});
      } else {
        res.json(individual);
      }
    })
  };
  /* update an individual */
  this.update = function(req, res) {
    console.log("server update params", req.params);
    console.log("server update body", req.body);
    Individual.findOne({ _id: req.body._id }, function(err, individual) {
      if (err) {
        res.json({ status: false, result: err });
      } else {
        individual.first_name = req.body.first_name;
        individual.last_name = req.body.last_name;
        individual.date_of_birth = new Date(req.body.birthday);
        individual.last_kitchen_visit = new Date(req.body.last_kitchen_visit);
        individual.last_shelter_visit = new Date(req.body.last_shelter_visit);
        individual.last_contact = new Date(req.body.last_contact);
       
        individual.save( function(err) {
          console.log("saving");
          if (err) {
            res.json({ status: false, result: individual });
          } else {
            res.json({ status: true, result: individual });
          }
        }); 
      }
    });
  };
}
module.exports = new Controller();
