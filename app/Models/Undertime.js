module.exports = (sequelize, type) => {
    return sequelize.define('undertime', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.STRING,
            allowNull: false
        },
        date: {
            type: type.DATEONLY,
            allowNull: true
        },
        time: {
            type: type.TIME,
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
        secretary_id: {
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