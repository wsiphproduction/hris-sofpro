module.exports = (sequelize, type) => {
    return sequelize.define('candidate_profile', {
        id: {
          type: type.INTEGER,
          primaryKey: true,
          autoIncrement: true
        },
        shortid: {
            type: type.STRING,
            allowNull: true
        },
        position_applying_for: {
        	type: type.STRING,
        	allowNull: false
        },
        first_name: {
        	type: type.STRING,
        	allowNull: true
        },
        last_name: {
        	type: type.STRING,
        	allowNull: true
        },
        current_address: {
        	type: type.STRING,
        	allowNull: true
        },
        permanent_address: {
        	type: type.STRING,
        	allowNull: true
        },
        email: {
        	type: type.STRING,
        	allowNull: true
        },
        phone_number: {
        	type: type.STRING,
        	allowNull: false,
        	defaultValue: ''
        },
        alternate_number: {
        	type: type.STRING,
        	allowNull: true
        },
        birthday: {
        	type: type.DATEONLY,
        	allowNull: true
        },
        gender: {
        	type: type.STRING,
        	allowNull: true
        },
        marital_status: {
        	type: type.STRING,
        	allowNull: true
        },
        nationality: {
        	type: type.INTEGER,
        	allowNull: true
        },
        interview_schedule: {
        	type: type.DATE(6),
        	allowNull: true
        },
        attachment: {
        	type: type.STRING,
        	allowNull: true
        },
        sss_number: {
        	type: type.STRING,
        	allowNull: true
        },
        pagibig_number: {
        	type: type.STRING,
        	allowNull: true
        },
        tin_number: {
        	type: type.STRING,
        	allowNull: true
        },
        philhealth_number: {
        	type: type.STRING,
        	allowNull: true
        },
        status: {
        	type: type.INTEGER,
        	allowNull: false,
        	defaultValue: 1
        },
        interview_status: {
        	type: type.INTEGER,
        	allowNull: false,
        	defaultValue: 1
        },
        note: {
        	type: type.TEXT,
        	allowNull: true
        },
        company: {
            type: type.INTEGER,
            allowNull: true
        },
        department: {
            type: type.INTEGER,
            allowNull: true
        },
        job_title: {
            type: type.INTEGER,
            allowNull: true
        },
        start_date: {
            type: type.DATEONLY,
            allowNull: true,
            defaultValue: null
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
    },
    {
    	freezeTableName: true,
    	timestamps: false
    });
}