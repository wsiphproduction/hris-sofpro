module.exports = (sequelize, type) => {
    return sequelize.define('leaves', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false
        },
        dates: {
            type: type.TEXT,
            allowNull: true
        },
        start_date: {
            type: type.DATEONLY,
            allowNull: true
        },
        end_date: {
            type: type.DATEONLY,
            allowNull: true
        },
        
        leave_type: {
            type: type.INTEGER,
            allowNull: false
        },
        other: {
            type: type.STRING,
            allowNull: true
        },
        no_of_days: {
            type: type.FLOAT,
            allowNull: true
        },
        credit: {
        	type: type.STRING,
        	allowNull: true
        },
        reason: {
            type: type.TEXT,
            allowNull: true
        },
        attachment: {
            type: type.STRING,
            allowNull: true
        },
        primary_status: {
            type: type.INTEGER,
            allowNull: false,
            defaultValue: 1
        },
        backup_status: {
            type: type.INTEGER,
            allowNull: false,
            defaultValue: 1
        },
        primary_approver: {
            type: type.INTEGER,
            allowNull: true
        },
        backup_approver: {
            type: type.INTEGER,
            allowNull: true
        },
        approver_note: {
            type: type.TEXT,
            allowNull: true
        },
        _token: {
            type: type.STRING,
            allowNull: true
        },
        is_hr: {
            type: type.INTEGER,
            allowNull: true,
        },
        secretary_id: {
            type: type.INTEGER,
            allowNull: true,
        },
        leave_duration: {
        	type: type.STRING,
        	allowNull: true
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