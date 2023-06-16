const fs = require('fs');
const Jimp = require('jimp');
const sizeOf = require('image-size');
const uuidv4 = require('uuid/v4');

module.exports = function resize(path, uploadPath, maxWidth, maxHeight){

	let image = './assets/uploads/logo/sample.jpg';

	var dimensions = sizeOf(path);

    let srcWidth = parseInt(dimensions.width);

    let srcHeight = parseInt(dimensions.height);

    let type = dimensions.type;
    
    var ratio = [maxWidth / srcWidth, maxHeight / srcHeight ];

    	ratio = Math.min(ratio[0], ratio[1]);

    let width = Math.trunc(srcWidth * ratio);

    let height = Math.trunc(srcHeight * ratio);

    
    let filename = uuidv4(path) +'.'+ type;

    Jimp.read(path).then(lenna => {
        return lenna
            .resize(width, height) // resize
            .quality(60) // set JPEG quality
            //.greyscale() // set greyscale
            .write(uploadPath + filename); // save
        })
    .catch(err => {
        console.log(err);
    });

  	return filename;
};