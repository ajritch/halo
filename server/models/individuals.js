var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var newSchema = new mongoose.Schema({
  first_name: { type: String },
  middle_name: { type: String, default: '' },
  last_name: { type: String },
  alias: { type: String, default: '' },
  ethnicity: { type: String, default: '' },
  gender: { type: String, default: '' },
  date_of_birth: { type: Date },
  eye_color: { type: String, default: '' },
  hair_color: { type: String, default: '' },
  hair_length: { type: String, default: '' },
  weight: { type: Number },
  height_feet: { type: Number },
  height_inch: { type: Number },
  notes_medical: [{
    userid: Number,
    text: String,
  }],
  notes_public: [{
    userid: Number,
    text: String,
  }],
  notes_social: [{
    userid: Number,
    text: String,
  }],
  notes_law_enforcement: [{
    userid: Number,
    text: String,
  }],
  notes_contacts: [{
    userid: Number,
    text: String,
  }],
  known_locations: [{
    lat: Number,
    lon: Number,
  }],
  alert: { 
    text: String, default: '' 
  },
  last_kitchen_visit: {
    type: Date
  },
  last_shelter_visit: {
    type: Date
  },
  last_contact: {
    type: Date
  },
  image: {
    type: String,
  },
  subject_id: {
    type: String,
  }

}, { timestamps : true });
mongoose.model('Individual', newSchema);

