const mongoose = require('mongoose');

class Mongoose {
    constructor() {
        try {
            mongoose.connect('mongodb+srv://himanshu:himanshu1234@cluster0-rhboz.mongodb.net/ActorsList?authSource=admin&replicaSet=Cluster0-shard-0&readPreference=primary&appname=MongoDB%20Compass&ssl=true', {
                auth: {
                    user: 'himanshu',
                    password: 'himanshu1234',
                },
                useNewUrlParser: true,
                useUnifiedTopology: true,
                useFindAndModify: false
            });
            // console.log(mongoose)
            return mongoose;
        } catch(err){
            console.log("Mongo Error: \n",err)
        }
    }
}

module.exports = new Mongoose();