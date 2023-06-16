
//const UserModel 		= require('../Model/UserModel');
//const TreeHelper = require('../Helper/TreeHelper');
//const arrayToTree = require('array-to-tree');

exports.index = function(req, res){
	let company = req.query.company ? req.query.company : '';
	res.render('Employee/hierarchy/index',{
		route: 'employee-hierarchy'
	});
	// UserModel._getByCompany(company).then(function(data){
	// 	records = data;
	// 	let count = records.length;
	// 	let dataTree = arrayToTree(records);
	// 	let tree = TreeHelper._hierarchyTree(dataTree);
	// 	res.render('Employee/hierarchy/index',{
	// 		route: 'employee-hierarchy',
	// 		tree: tree,
	// 		count: count
	// 	});
	// });
	
// 	var dataOne = [
//   {
//     id: 1,
//     name: 'Portfolio',
//     parent_id: 0
//   },
//   {
//     id: 2,
//     name: 'Web Development',
//     parent_id: 1
//   },
//   {
//     id: 3,
//     name: 'Recent Works',
//     parent_id: 2
//   },
//   {
//     id: 4,
//     name: 'About Me',
//     parent_id: 0
//   }
// ];
// 	let dataTree = arrayToTree(dataOne);
// 	console.log(dataTree[0]['children'][0]);

// 	let tree = TreeHelper._renderTree(dataTree);
// 	res.send(tree);
}


// exports.get = function(req, res){
// 	let id = req.body.id;
// 	UserModel._getByCompany(id).then(function(data){
// 		users = data;
// 		res.status(200).json({
// 			success: false,
//             users: users
// 		});
// 	});
// }