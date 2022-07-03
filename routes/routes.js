var router = require('express').Router();

var controller = require("../controllers/controller");

function getData(req, res){
    controller.getData(req)
        .then(data => {
            res.status(200).json(data);
        })
        .catch(err => {
            res.status(500).json(err)
        });
}

function getMarvelData(req, res){
    controller.getMarvelData()
        .then(data => {
            res.status(200).json(data);
        })
        .catch(err => {
            res.status(500).json(err)
        });
}

router.post('/getData' , getData)

router.get('/getMarvelData', getMarvelData)

router.get('/', (req, res) => {
    res.status(200).json({
        code: 200,
        msg: "Home page reached."
    })
})

module.exports = router;