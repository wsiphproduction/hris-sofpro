const $env 	= require('dotenv').config();
const moment     	= require('moment-timezone');
	moment.tz.setDefault($env.parsed.moment_timezone);
const {
	NotificationsModel,
	NotificationsReceiverModel
} = require('../../config/Sequelize');

function Notification(){

	this.notify = function(notificationMessage, receiver, module, method){
		NotificationsModel.create(notificationMessage).then(function(data){
			let insertId = data.id;
			let user = [...new Set(receiver)];
			if(user){
				for(let x in user){
					let receiverData = {
						notification_id: insertId,
						user_id: user[x]
					}
					NotificationsReceiverModel.create(receiverData);
				}
			}
		});
	}

}

module.exports = new Notification();