var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var newSchema = new mongoose.Schema({
  username: { type: String },
  first_name: { type: String },
  last_name: { type: String },
  admin_level: { type: Number, default: 0 },
  access_level: { type: Number, default: 0 },
  photo_use: { type: Number, default: 0 }
}, { timestamps: true });
mongoose.model('User', newSchema);
