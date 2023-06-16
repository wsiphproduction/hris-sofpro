const multer = require('multer');

const upload = multer({
	limits: {
		fileSize: 1 * 100 * 100,
	}
});

module.exports = upload;