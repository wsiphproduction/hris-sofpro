const { UserModel, CandidateProfileModel } = require('../../config/Sequelize');

exports.index = function(req, res){
	// UserModel.findOne({ where: {id:1} }).then(function(data){
	// 	user = data;
	// 	return CandidateProfileModel.findAll();
	// }).then(function(data){
	// 	candidate = data;
	// 	let array = {
	// 		user: user,
	// 		candidate: candidate
	// 	}
	// 	let date = res.locals.moment(user.created_at).format('YYYY-MM-DD hh:mm:ss')
	// 	res.json(date);
	// });

	let condition = {}
		condition.where = {
			interview_status: 1,
			$and: [
				{
					birthday: {
						$between: ['2019-06-01','2019-06-30']
					}
				}
			]
			
		}
	console.log(condition);
	CandidateProfileModel.findAll(condition).then(function(record){
		res.json(record);
	});
}