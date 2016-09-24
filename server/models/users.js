var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var newSchema = new mongoose.Schema({
  username: { type: String },
  first_name: { type: String },
  last_name: { type: String },
  admin_level: { type: Number },
  access_level: { type: Number },
  photo_use: { type: Number }
}, { timestamps: true });
mongoose.model('User', newSchema);
