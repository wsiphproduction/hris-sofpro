module.exports = (sequelize, type) => {
    return sequelize.define('employments', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: true
        },
        employee_number: {
            type: type.INTEGER,
            allowNull: true
        },
        company_branch_id: {
            type: type.INTEGER,
            allowNull: true
        },
        company_id: {
            type: type.INTEGER,
            allowNull: true
        },
        division_id: {
            type: type.INTEGER,
            allowNull: true
        },
        department_id: {
            type: type.INTEGER,
            allowNull: true
        },
        section_id: {
            type: type.INTEGER,
            allowNull: true
        },
        position_id: {
            type: type.INTEGER,
            allowNull: true
        },
        position_classification_id: {
            type: type.INTEGER,
            allowNull: true
        },
        position_category_id: {
            type: type.INTEGER,
            allowNull: true
        },

        approving_organization: {
            type: type.STRING,
            allowNull: true
        },
        work_area_id: {
            type: type.INTEGER,
            allowNull: true
        },
        branch_id: {
            type: type.INTEGER,
            allowNull: true
        },
        job_title_id: {
            type: type.INTEGER,
            allowNull: true
        },
        team_id: {
            type: type.INTEGER,
            allowNull: true
        },
        location_id: {
            type: type.INTEGER,
            allowNull: true
        },
        date_entry: {
            type: type.DATEONLY,
            allowNull: true
        },
        date_exit: {
            type: type.DATEONLY,
            allowNull: true
        },
        comment: {
            type: type.TEXT,
            allowNull: true
        },
        status: {
            type: type.INTEGER,
            allowNull: false,
            defaultValue: 1
        },
        created_by: {
            type: type.INTEGER,
            allowNull: true,
            defaultValue: 0
        },
        updated_by: {
            type: type.INTEGER,
            allowNull: true,
            defaultValue: 0
        },
        created_at: {
            type: 'TIMESTAMP',
            allowNull: false,
            defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
        },
        updated_at: {
            type: 'TIMESTAMP',
            allowNull: false,
            defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
        },
        cost_center: {
            type: type.STRING,
            allowNull: true
        },
        union_member: {
            type: type.BOOLEAN,
            allowNull: false,
            defaultValue: 0
        },
        type_of_separation: {
            type: type.STRING,
            allowNull: true
        },
        statutory_number: {
            type: type.STRING,
            allowNull: true
        },
        insurance_entitlement: {
            type: type.BOOLEAN,
            allowNull: true
        },
        medical_condition: {
            type: type.STRING, // 1 = 'Fit To Work', 2 = 'Light Job'
            allowNull: true
        },
        employee_type: {
            type: type.STRING, 
            allowNull: true
        },
        job_description: {
            type: type.STRING, 
            allowNull: true
        },
    },
    {
        freezeTableName: true,
    	timestamps: false
    });
}