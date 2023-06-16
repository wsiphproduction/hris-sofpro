const UserRole = require('../Helper/UserRole');
const { 
	UsersModel, 
	CandidateProfileModel, 
	InterviewModel, 
	InterviewRatingModel ,
	TaxonomyModel
} = require('../../config/Sequelize');

exports.index = function(req, res){
	let user = res.locals.user;
	UserRole.get_role(user, 'recruitment-rating').then(function(data){
		user_role = data;
		if(!user_role.read){
			res.render('Errors/403');
		}else{
			UserRole.allRead(user).then(function(data){
				usrRole = data;
				res.render('Recruitment/Rating/index',{
					user_role: user_role,
					usrRole: usrRole,
					route: 'recruitment-rating'
				});
			});
		}
	});	
	
}

exports.get = function(req, res){
	let status = req.body.status;
	let start = req.body.start; 
		start = start ? start +' 00:00:00' : '';
	let end = req.body.end; 
		end = end ? end +' 23:59:59' : '';
	let page = req.body.page;
	let limit = req.body.limit ? parseInt(req.body.limit) : 25;
	let offset   = (parseInt(page) - 1) * parseInt(limit);

	let where = {}
	if(status){
		where.interview_status = status;
	}
	if((start && end) && (start <= end)){
		where.interview_schedule = {
	        $between: [start, end]
	    }
	}
	
	CandidateProfileModel.count({
		where: where
	}).then(function(data){
		numrows = data;
		return CandidateProfileModel.findAll({
			where: where,
			offset: offset,
	    	limit: limit,
	    	include:[
	    		{
	    			model: InterviewModel,
	    			include: [ UsersModel ]
	    		}
	    	]
		});
	}).then(function(data){
		records = data;

		if(limit < numrows){
            count = numrows / limit;
            count = Math.ceil(count);
        }else{
        	count = 0;
        }
        res.status(200).json({
            success: true,
            records: records,
			count: count,
        });
	});
}

exports.fetch = function(req, res){
	let user = res.locals.user;
	let id = req.body.id;
	InterviewModel.findOne({
		where: {
			candidate_profile_id: id
		},
		include: [{
			model: UsersModel,
			attributes: ['id', 'first_name', 'last_name']
		}]
	}).then(function(data){
		interview = data;
		if(interview){
			return InterviewRatingModel.findAll({
				where: {
					interview_id: interview.id
				}
			});
		}else{
			return TaxonomyModel.findAll({
				where:{
					parent_id: 21
				},
				attributes: ['title']
			});
		}
	}).then(function(data){
		question = data;
		return CandidateProfileModel.findOne({
			where:{
				id: id
			}
		});
		
	}).then(function(data){
		profile = data;
		return UsersModel.findOne({
			where: {
				id: user.id,
			},
			attributes: ['id', 'first_name', 'last_name']
		});
		
	}).then(function(data){
		let user_data = data;
		res.status(200).json({
            success: true,
            user: user_data,
            profile: profile,
            question: question,
			interview: interview,
        });
	});
}

exports.store = function(req, res){
	let id = req.body.id;
	let status = req.body.status;
	let candidate_profile_id = req.body.candidate_profile_id;
	let interview_date = res.locals.moment(new Date(req.body.interview_date)).format('YYYY-MM-DD');
	let interviewer = req.body.interviewer;
	let overall_assessment = req.body.overall_assessment;
	let ratings = req.body.ratings;
	
	let reqBody = {
		candidate_profile_id: candidate_profile_id,
		interview_date: interview_date,
		interviewer: interviewer,
		overall_assessment: overall_assessment,
	}
	let reqProfile = {
		interview_status: status
	}
	if(status == 3){
		reqProfile.status = 4;
	}else if(status == 4){
		reqProfile.status = 6;
	}

	CandidateProfileModel.update(reqProfile, {
		where: {
			id: candidate_profile_id
		}
	});

	if(!id){
		//Insert if id is null
		InterviewModel.create(reqBody).then(function(data){
			result = data;
			let interview_id = result.id;
			if(ratings){
				//Insert new Rating.
				for(let x in ratings){
					let reqRating = {
						interview_id: interview_id,
						title: ratings[x]['title'],
						candidate_rating: ratings[x]['candidate_rating'],
						job_relevance: ratings[x]['job_relevance'],
						notes: ratings[x]['notes'],
					}
					//console.log(reqRating);
					InterviewRatingModel.create(reqRating);
				}
			}
		});
	}else{
		//Insert if id is null
		InterviewModel.update(reqBody,{
			where: {
				id: id
			}
		}).then(function(data){
			if(ratings){
				//Insert new Rating.
				for(let x in ratings){
					let rating_id = ratings[x]['id'];
					let reqRating = {
						candidate_rating: ratings[x]['candidate_rating'],
						job_relevance: ratings[x]['job_relevance'],
						notes: ratings[x]['notes'],
					}
					InterviewRatingModel.update(reqRating,{
						where: {
							id: rating_id
						}
					});
				}
			}
			
		});
	}
	
	res.status(200).json({
		success: true,
		action: 'fetch',
		msg: 'Record has been updated.'
	});
}