function Pagination(){

	this.generate = function(numrows, limit, page, link){
		let links = [];
		let offset 	= 3;
		let current = page;
		let betweenFirst = parseInt(current) - parseInt(offset);
		let betweenLast  = parseInt(current) + parseInt(offset);
		let count = 0;
		if(limit < numrows){
			count = numrows / limit;
			count = ~~count;
		}
		let first 	= 1;
		let last 	= count;
		
		for(let i=1; i <= count; i++){
			
			let label  = i;
			let active = link;
			if(current == label){
				active = 'active';
			}

			//First
			if(i == 1){
				links.push({
					link: link + first,
					label: 'First',
					class: ''
				});
			}

			if(label >= betweenFirst  && label <= betweenLast){
				links.push({
					link: link + i,
					label: label,
					class: active
				});
			}

			//Last
			if(i == last){
				links.push({
					link: link + last,
					label: 'Last',
					class: ''
				});
			}

		}
		return links;
	}

}

module.exports = new Pagination();