var fs = require('fs');
var scrapper = require("../scrapper");
var marvel = require("../models/marvel");

class Controller {

    getData(req) {
        return new Promise((resolve, reject) => {
            console.log(req.body)
            // console.log("REQ: ", req.body, Object.keys(req.body).length);
            if (req.body.constructor === Object && Object.keys(req.body).length != 0) {
                var temp = JSON.stringify(req.body)
                fs.appendFile('myjsonfile.json', temp, function (err) {
                    if (err) throw err;
                    console.log('Saved!');
                    resolve({
                        code: 200,
                        data: req.body
                    })
                });
            }
            else {
                reject({
                    code: 500,
                    msg: "Error in 'req.body'."
                })
            }
        });
    }

    getMarvelData() {
        return new Promise((resolve, reject) => {
            console.log("-------------------------------------------------------------------------------");
            console.log("IN CONTROLLER");
            scrapper.getData()
                .then(data => {
                    // console.log(`Data: ${data}`)
                    if (data.length > 0) {
                        // resolve(data);
                        let c = 0;
                        data.map(x => {
                            var schema = new marvel(x);
                            console.log(schema)

                            schema.save()
                                .then(done => {
                                    resolve(done)
                                    console.log("saved...  " + ++c)
                                })
                                .catch(error => {
                                    reject(error)
                                });
                        })
                    }

                })
                .catch(err => {
                    reject(err);
                });
        })
    }
}

module.exports = new Controller();
