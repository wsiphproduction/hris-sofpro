module.exports = (sequelize, type) => {
    return sequelize.define('overtimes', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.STRING,
            allowNull: false
        },
        type: {
            type: type.STRING,
            allowNull: false
        },
        start_date: {
            type: type.DATEONLY,
            allowNull: true
        },
        end_date: {
            type: type.DATEONLY,
            allowNull: true
        },
        start_time: {
            type: type.TIME,
            allowNull: true
        },
        end_time: {
            type: type.TIME,
            allowNull: true
        },
        actual_check_in: {
            type: type.TIME,
            allowNull: true
        },
        actual_check_out: {
            type: type.TIME,
            allowNull: true
        },
        no_of_hours: {
            type: type.FLOAT,
            allowNull: true
        },
        purpose: {
            type: type.TEXT,
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
        night_diff: {
            type: type.FLOAT,
            allowNull: true
        },
        _token: {
            type: type.STRING,
            allowNull: true
        },
        secretary_id: {
            type: type.INTEGER,
            allowNull: true
        },
        shift_id: {
            type: type.INTEGER,
            allowNull: true
        },
        attachment: {
            type: type.STRING,
            allowNull: true
        },
        break_hours: {
            type: type.INTEGER,
            allowNull: true
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