const $env  = require('dotenv').config();
const session       = require('express-session');
const moment= require('moment-timezone');
    moment.tz.setDefault($env.parsed.moment_timezone);
const {
    Op,
    sequelize,
    UsersModel,
    BrandingModel,
    ConfigModel,
    EmploymentsModel
} = require('../../config/Sequelize');

function appMiddleware(){

    this.initialize = async (req, res, next) => {
        let userId = $env.parsed.APP_ENV == 'production' && req.session.user ? req.session.user.id : $env.parsed.USER_ID;
        let branding = await sequelize.transaction( async (t) => {
            return await BrandingModel.findOne({
                raw: true
            }, {transaction: t});
        });
        let user = await sequelize.transaction( async (t) => {
            return await UsersModel.findOne({
                where: {
                    id: userId
                },
                raw: true,
                attributes: ['id', 'shortid', 'first_name', 'last_name', 'gender', 'birthdate', 'avatar', 'nationality', 'marital_status', 'email', 'username', 'status', 'user_role', 'company_branch_id', 'department_id']
            }, {transaction: t});
        });
        let isManager = await sequelize.transaction( async (t) => {
            return await UsersModel.count({
                where: {
                    [Op.or]: [
                        {
                            approver_id: userId
                        },{
                            secondary_approver_id: userId
                        }
                    ]
                },
            }, {transaction: t});
        });
        let isSupervisor = await sequelize.transaction( async (t) => {
            return await UsersModel.count({
                where: {
                    [Op.or]: [
                        {
                            approver_id: userId
                        },{
                            secondary_approver_id: userId
                        },{
                            secretary_id: userId
                        },{
                            alternate_secretary: userId
                        },{
                            hr_generalist_id: userId 
                        }
                    ]
                },
            }, {transaction: t});
        });
        let isHRGeneralist = await sequelize.transaction( async (t) => {
            return await UsersModel.count({
                where: {
                    hr_generalist_id: userId
                },
            }, {transaction: t});
        });        
        let ConfigData = await sequelize.transaction( async (t) => {
            return await ConfigModel.findOne({
                where: {
                    id: 1
                }, 
            }, {transaction: t});
        });
        let employments = await sequelize.transaction( async (t) => {
            return await EmploymentsModel.findOne({
                where: {
                    user_id: userId,
                    status: 1,
                },
                attributes: ['id', 'user_id', 'division_id', 'department_id', 'section_id', 'approving_organization']
            }, {transaction: t});
        });
        ConfigData = ConfigData.json ? JSON.parse(ConfigData.json) : null;
        res.cookie('XSRF-TOKEN', req.csrfToken());
        res.locals.csrftoken = req.csrfToken();
        res.locals.baseUrl = $env.parsed.APP_URL;
        res.locals.url = req.url;
        res.locals.APP_NAME = branding && branding.name ? branding.name : $env.parsed.APP_NAME;
        res.locals.APP_LOGO = branding && branding.logo ? branding.logo : $env.parsed.APP_LOGO;
        res.locals.BRANDING = branding && branding.branding ? branding.branding : 0;
        res.locals.ENV = $env.parsed.APP_ENV;
        res.locals.moment = moment;
        res.locals.user = user;
        res.locals.Config = ConfigData;
        res.locals.isManager = isManager;
        res.locals.isSupervisor = isSupervisor;
        res.locals.isHRGeneralist = isHRGeneralist;
        if (employments){
            res.locals.approvingOrganization = employments ? employments.approving_organization : '';
            res.locals.approvingOrganizationId = employments.approving_organization == 'department' ? employments.department_id : employments.approving_organization == 'section' ? employments.section_id : employments.division_id;
        }
        next();
    }

    this.countUser = async (req, res, next) => {
        let count = await sequelize.transaction( async (t) => {
            return await UsersModel.count({}, {transaction: t});
        });

        if(count){
            if($env.parsed.APP_ENV == 'production' && !req.session.user){
                res.render('Auth/login');
                //res.render('Install/register');
            }else{
                next();
            }
        }else{
            res.render('Install/register');
        }
    }

}

module.exports = new appMiddleware();