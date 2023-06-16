var path = require('path');

function Global(){

	this.currencyFormat = function(num){
		return num.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,');
	}

	this.checkCutoff = function(date, cutoff){
		date = new Date(date);
		cutoff = new Date(cutoff);
		if(date <= cutoff){
			return true;
		}else{
			return false;
		}
	}

	this.fileIcon = function(filename){
		let array = filename.split('.');
		let ext = path.extname(filename);
		
		let icon = '';
		switch(ext){
			case '.png':
			case '.jpg':
			case '.jpeg':
			case '.gif':
				icon = '<i class="mdi mdi-file-image"></i>';
				break;
			case '.pdf':
				icon = '<i class="mdi mdi-file-pdf"></i>';
				break;
			case '.xls':
			case '.xlsb':
			case '.xlsm':
			case '.xlsx':
			case '.csv':
			case '.dbf':
			case '.ods':
				icon = '<i class="mdi mdi-file-excel-box"></i>';
				break;
			case '.doc':
			case '.docm':
			case '.docx':
			case '.dot':
			case '.dotm':
			case '.dotx':
			case '.wps':
				icon = '<i class="mdi mdi-file-word-box"></i>';
				break;
			case '.bmp':
			case '.emf':
			case '.pot':
			case '.potm':
			case '.ppa':
			case '.pps':
			case '.ppt':
			case '.pptx':
			case '.rtf':
				icon = '<i class="mdi mdi-file-powerpoint"></i>';
				break;
			default:
				icon = '<i class="mdi mdi-file"></i>';
		}

		return icon;
	}

	this.check_role = function(module, type){
		console.log(this.user_role);
	}
}

module.exports = new Global();