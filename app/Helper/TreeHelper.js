function TreeHelper(){

	this._hierarchyTree = function(tree){
		var e, html, _i, _len;
		html = "<ul>";
		for (_i = 0, _len = tree.length; _i < _len; _i++) {
			e = tree[_i];
			html += `<li><span class="button">` + e.first_name +' '+ e.last_name + `</span><span class="remove" v-on:click="remove(`+ e.id +`)"><i class="mdi mdi-close"></i></span>`;
			if (e.children != null) {
				html += this._hierarchyTree(e.children);
			}
			html += "</li>";
		}
		html += "</ul>";
		return html;
	}

	this._taxonomyTree = function(tree, spacing = '', user_role){
		let role = user_role;
		//console.log(role);
		var e, html, _i, _len;
		html = "";
		for (_i = 0, _len = tree.length; _i < _len; _i++) {
			e = tree[_i];
			let code = e.code ? e.code : '';
			let status = e.status == 1 ? 'Active' : 'Inactive';
			let space = spacing + '&nbsp; &nbsp;';
			let arrow = spacing ? ' → ':'';
			let disabled = '';
			let removeBtn = '';
			if(role.modify){
				disabled = 'v-on:click="edit('+ e.id +')"';
			}else{
				disabled = 'disabled';
			}
			if(role.destroy){
				if(e.parent_id == 1 || e.parent_id == 2 || e.parent_id == 270){
					removeBtn = `v-on:click="archive(`+ e.id +`,'settings/taxonomy/remove/`+e.parent_id+`')"`;	
				}else{
					removeBtn = 'disabled style="display: none;"';
				}
			}else{
				removeBtn = 'disabled style="display: none;"';
			}
			html += `
				<tr>
					<td>`+ spacing + arrow + e.title +`</td>
					<td>`+ code +`</td>
					<td class="text-center">`+ status +`</td>
					<td class="text-left">
						<button class="btn btn-sm btn-outline-success" title="edit" `+disabled+` ><i class="mdi mdi-pen"></i></button>
						<button class="btn btn-sm btn-outline-warning" title="remove" `+removeBtn+` ><i class="mdi mdi-delete"></i></button>
					</td>
				</tr>
				`;
			if (e.children != null) {
				html += this._taxonomyTree(e.children, space, role);
			}
		}
		return html;
	}

	this._taxonomyOption = function(tree, spacing = ''){
		var e, html, _i, _len;
		html = "";
		for (_i = 0, _len = tree.length; _i < _len; _i++) {
			e = tree[_i];
			let space = spacing + '&nbsp; &nbsp;';
			let arrow = spacing ? ' → ':'';
			html += `<option value="`+ e.id +`">`+ space + arrow + e.title +`</option>`;
			if (e.children != null) {
				html += this._taxonomyOption(e.children, space);
			}
		}
		return html;
	}
}

module.exports = new TreeHelper();