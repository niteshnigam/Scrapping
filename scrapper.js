const rp = require("request-promise");
const cheerio = require('cheerio')

class Scrapper {
    constructor(){

    }
    getData() {
        return new Promise((resolve, reject) => {
            var options = {
                uri: 'https://www.buzzfuse.net/123-1/top-50-most-powerful-characters-in-marvel-comics/',
            };
            let result = [];

            rp(options)
                .then((res) => {

                    const $ = cheerio.load(res);
                    let div = $('#articlefull');
                    // let div =$('#articlefull').first().children();

                    // console.log(div.first().children().length)

                    div.map((x, i) => {
                        let temp = {};
                        // console.log(`x = ${x}\n----------------------------------\ni = ${i}\nType of i = ${typeof i}`)
                        // console.debug($(i).children().length)
                        temp.title = $(i).children().first().text();
                        temp.title = temp.title.substring(temp.title.indexOf(" ") + 1, temp.title.length)
                        // console.log(temp)
                        // console.log($(i).children("#slideimage").children("img").eq(0).attr("data-original"));
                        // console.log($(i).children("#slideimage").find("img").attr("data-original"));
                        temp.imageUrl = $(i).children("#slideimage").find("img").attr("data-original");

                        temp.description = $(i).children("#articledescription").map(function () {
                            return $(this).text();
                        }).toArray();

                        // qwerty

                        result.push(temp)
                    })
                    result = result.reverse();
                    resolve(result);

                })
                .catch(err => {
                    console.log(err)
                    reject(err)
                })
            // console.log(result);
        })
    }
}

module.exports = new Scrapper();