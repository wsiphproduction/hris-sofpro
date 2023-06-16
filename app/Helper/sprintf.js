function sprintf(){

	this.require = function(str){
		return `The ${str} field is required.`;
	}

	this.unique = function(str){
		return `This ${str} is already registered.`;
	}

}

module.exports = new sprintf();