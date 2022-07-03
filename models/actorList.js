const mongoose = require("../db/db");
var ObjectId = mongoose.Schema.Types.ObjectId;

const actorListSchema = mongoose.Schema({
    // fromUser: {
    //     type: ObjectId,
    //     ref: 'users'
    // },
    // toUser: {
    //     type: ObjectId,
    //     ref: 'users'
    // },
    // message: String,
    // sentAt: {
    //     type: String,
    //     default: new Date().getTime()
    // }
});

const actor = mongoose.model('actorlist', actorListSchema);

module.exports = actor;