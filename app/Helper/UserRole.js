var _ = require('lodash');
const { 
	Op,
	UsersModel,
	RolePermissionModel,
	UserSettingModel
} = require('../../config/Sequelize');

exports.get_role = function(user, module){
	// console.log(module);
	let role = user.user_role;
	let roleObject = role ? role.split(',') : null;
	return new Promise(function(resolve, reject){
		RolePermissionModel.count({
			where: {
				module_tag: module,
				read: 1,
				role_id: {
					$in: roleObject
				}
			}
		}).then(function(data){
			read = data;
			return RolePermissionModel.count({
				where: {
					module_tag: module,
					write: 1,
					role_id: {
						$in: roleObject
					}
				}
			})
		}).then(function(data){
			write = data;
			return RolePermissionModel.count({
				where: {
					module_tag: module,
					modify: 1,
					role_id: {
						$in: roleObject
					}
				}
			});
		}).then(function(data){
			modify = data;
			return RolePermissionModel.count({
				where: {
					module_tag: module,
					delete: 1,
					role_id: {
						$in: roleObject
					}
				}
			})
		}).then(function(data){
			destroy = data;
			let result = {
				read: read > 0 ? 1 : 0,
				write: write  > 0 ? 1 : 0,
				modify: modify  > 0 ? 1 : 0,
				destroy: destroy  > 0 ? 1 : 0,
			}
			return resolve(result);
		});
	});
}


exports.findByModule = function(module){
	return RolePermissionModel.findAll({
		where: {
			module_tag: module
		}
	});
}

exports.allRead = function(user){
	let role = user.user_role ? user.user_role : null;
	let object = role ? role.split(',') : null;
	let where = {
		read: 1
	}
	if(role && object){
		where.role_id = {
			[Op.in]: object
		}
	}
	return new Promise(function(resolve, reject){
		RolePermissionModel.findAll({
			where: where,
			// group:['module_tag'],
			attributes: ['id','module_tag', 'read','write','modify','delete'],
			raw: true
		}).then(function(data){
			roles = data;
			roles = _.groupBy(roles, 'module_tag');
			// console.log(roles);
			// roles = role && object ? roles : null;
			// console.log(roles);
			return UserSettingModel.findOne({
				where: {
					user_id: user.id
				}
			});
			
		}).then(function(data){
			setting = data;
			setting = setting ? JSON.parse(JSON.stringify(setting)) : null;
			let array = {};
			array.has_overtime = setting && setting.has_overtime ? setting.has_overtime : '';
			if(roles){
				for(let key in roles){
					let k = key;
					let data =  roles[key];
					var foundValue = data.filter(obj=>obj.read=='1');
					array[k] = foundValue && foundValue.length > 0 ? 1 : 0;
				}
			}
			return resolve(array);
		});
	});
}
