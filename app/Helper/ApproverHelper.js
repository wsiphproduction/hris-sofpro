const _ = require('underscore');
const { 
	Op,
    EmploymentsModel,
	UsersModel,
	Division,
    Section,
    Department
} = require('../../config/Sequelize');

function ApproverHelper(){
    this.proccessDivision = async(id, approver_id, secretary_id, alternate_secretary)=>{
    //this.proccessDivision = function(id, approver_id, secretary_id, alternate_secretary){
        Division.findOne({
			where:{
				id:id
			}
		}).then(data=>{
			divisionData = data;

            let userFilter = {}
            let reqData = {}

            let approverChanged = divisionData.manager_id == approver_id ? false : true
            let secretaryChanged = divisionData.secretary_id == secretary_id ? false : true
            let alternateSecretaryChanged = divisionData.alternate_secretary == alternate_secretary ? false : true
            EmploymentsModel.findAll({
                where: {
                    division_id: id,
                    approving_organization: "division"
                },
                raw: false,
            }).then(data=>{
                users = data;
                
                if(users && users.length){
                    let userIDs = _.pluck(users, 'user_id');
                    userIDs = [...new Set(userIDs)];
            
                    if(approverChanged){
                        userFilter[Op.and] = {
                            id: {
                                    [Op.in]: userIDs
                            },
                            approver_id: divisionData.manager_id
                        }
                        reqData = {
                            approver_id: approver_id
                        }
                        
                        this.changeUserApprover(userFilter, reqData)
                    }

                    if(secretaryChanged){
                        userFilter[Op.and] = {
                            id: {
                                    [Op.in]: userIDs
                            },
                            secretary_id: divisionData.secretary_id
                        }
                        reqData = {
                            secretary_id: secretary_id
                        }
                        
                        this.changeUserApprover(userFilter, reqData) 
                    }

                    if(alternateSecretaryChanged){
                        userFilter[Op.and] = {
                            id: {
                                    [Op.in]: userIDs
                            },
                            alternate_secretary: divisionData.alternate_secretary
                        }
                        reqData = {
                            alternate_secretary: alternate_secretary
                        }
                        
                        this.changeUserApprover(userFilter, reqData) 
                    }
                }
            });
        });
    }
    
    this.proccessSection = function(id, approver_id, secretary_id, alternate_secretary){
        Section.findOne({
			where:{
				id:id
			}
		}).then(data=>{
			sectionData = data;

            let userFilter = {}
            let reqData = {}

            let approverChanged = sectionData.supervisor_id == approver_id ? false : true
            let secretaryChanged = sectionData.secretary_id == secretary_id ? false : true
            let alternateSecretaryChanged = sectionData.alternate_secretary == alternate_secretary ? false : true

            EmploymentsModel.findAll({
                where: {
                    section_id: id,
                    approving_organization: "section"
                },
                raw: true,
            }).then(data=>{
                users = data;
                
                if(users && users.length){
                    let userIDs = _.pluck(users, 'user_id');
                    userIDs = [...new Set(userIDs)];

                    if(approverChanged){
                        userFilter[Op.and] = {
                            id: {
                                    [Op.in]: userIDs
                            },
                            approver_id: sectionData.supervisor_id
                        }
                        reqData = {
                            approver_id: approver_id
                        }
                        
                        this.changeUserApprover(userFilter, reqData)
                    }

                    if(secretaryChanged){
                        userFilter[Op.and] = {
                            id: {
                                    [Op.in]: userIDs
                            },
                            secretary_id: sectionData.secretary_id
                        }
                        reqData = {
                            secretary_id: secretary_id
                        }
                        
                        this.changeUserApprover(userFilter, reqData) 
                    }

                    if(alternateSecretaryChanged){
                        userFilter[Op.and] = {
                            id: {
                                    [Op.in]: userIDs
                            },
                            alternate_secretary: sectionData.alternate_secretary
                        }
                        reqData = {
                            alternate_secretary: alternate_secretary
                        }
                        
                        this.changeUserApprover(userFilter, reqData) 
                    }
                }
            });
        });
    }

    this.proccessDepartment = function(id, approver_id, secretary_id, alternate_secretary, hr_generalist_id){
        Department.findOne({
			where:{
				id:id
			}
		}).then(data=>{
			departmentData = data;

            let userFilter = {}
            let reqData = {}

            let approverChanged = departmentData.manager_id == approver_id ? false : true
            let secretaryChanged = departmentData.secretary_id == secretary_id ? false : true
            let alternateSecretaryChanged = departmentData.alternate_secretary == alternate_secretary ? false : true
            let hrGeneralistChanged = departmentData.hr_generalist_id == hr_generalist_id ? false : true
            
            EmploymentsModel.findAll({
                where: {
                    department_id: id,
                    approving_organization: "department"
                },
                raw: false,
            }).then(data=>{
                users = data;
                
                if(users && users.length){
                    let userIDs = _.pluck(users, 'user_id');
                    userIDs = [...new Set(userIDs)];

                    if(approverChanged){
                        userFilter[Op.and] = {
                            id: {
                                    [Op.in]: userIDs
                            },
                            approver_id: departmentData.manager_id,
                        }
                        reqData = {
                            approver_id: approver_id
                        }
                        
                        this.changeUserApprover(userFilter, reqData)
                    }

                    if(secretaryChanged){
                        userFilter[Op.and] = {
                            id: {
                                    [Op.in]: userIDs
                            },
                            secretary_id: departmentData.secretary_id
                        }
                        reqData = {
                            secretary_id: secretary_id
                        }
                        
                        this.changeUserApprover(userFilter, reqData) 
                    }

                    if(alternateSecretaryChanged){
                        userFilter[Op.and] = {
                            id: {
                                    [Op.in]: userIDs
                            },
                            alternate_secretary: departmentData.alternate_secretary
                        }
                        reqData = {
                            alternate_secretary: alternate_secretary
                        }
                        
                        this.changeUserApprover(userFilter, reqData) 
                    }

                    if(hrGeneralistChanged){
                        userFilter[Op.and] = {
                            id: {
                                    [Op.in]: userIDs
                            },
                            hr_generalist_id: departmentData.hr_generalist_id
                        }
                        reqData = {
                            hr_generalist_id: hr_generalist_id
                        }
                        
                        this.changeUserApprover(userFilter, reqData)
                    }
                }
            });
        });
    }


    this.changeUserApprover = function(userFilter, reqData){
        UsersModel.update(reqData,{
			where:userFilter
		});

        UsersModel.findAll(reqData,{
			where:userFilter
            }).then(data=>{
            users = data;
            let userIDs = _.pluck(users, 'id');
            userIDs = [...new Set(userIDs)];
		});
    }
}

module.exports = new ApproverHelper();