const { argv } = require('node:process');

argv.forEach((args) => {
    var url = process.argv.slice(2);
    fetch(url)
        .then(response => response.text())
        .then(htmlContent => {


            const jsdom = require("jsdom");

            const dom = new jsdom.JSDOM(htmlContent);
            console.log(htmlContent)
            console.log(dom.window.document.title);


        })
        .catch(function(err) {

        });


});


