module.exports = (sequelize, type) => {
    return sequelize.define('change_log', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false
        },
        shift_id: {
            type: type.INTEGER,
            allowNull: false
        },
        log_date: {
            type: type.DATEONLY,
            allowNull: false
        },
        orig_login_time: {
            type: type.TIME,
            allowNull: true
        },
        orig_logout_time: {
            type: type.TIME,
            allowNull: true
        },
        req_login_time: {
            type: type.TIME,
            allowNull: true
        },
        req_logout_time: {
            type: type.TIME,
            allowNull: true
        },
        note: {
            type: type.STRING,
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
        primary_approver: {
            type: type.INTEGER,
            allowNull: false,
        },
        backup_status: {
            type: type.INTEGER,
            allowNull: false,
            defaultValue: 1
        },
        backup_approver: {
            type: type.INTEGER,
            allowNull: false,
        },
        secretary_id: {
            type: type.INTEGER,
            allowNull: true,
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