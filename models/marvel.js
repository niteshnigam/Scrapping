const mongoose = require("../db/dbMarvel");
var ObjectId = mongoose.Schema.Types.ObjectId;

const marvelSchema = mongoose.Schema({
    title: {
        type: String
    },
    imgUrl: String,
    description: {
        type: Array
    }
});

const marvel = mongoose.model('marvel', marvelSchema);

module.exports = marvel;