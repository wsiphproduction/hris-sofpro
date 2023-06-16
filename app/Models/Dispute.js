const SequelizeSlugify = require('sequelize-slugify');

module.exports = (sequelize, type) => {
    return sequelize.define('dispute', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false
        },
        year: {
            type: type.INTEGER,
            allowNull: true
        },
        month: {
            type: type.STRING,
            allowNull: true
        },
        period: {
            type: type.STRING,
            allowNull: true
        },
        hour: {
            type: type.INTEGER,
            allowNull: false
        },
        type: {
            type: type.INTEGER,
            allowNull: false
        },
        date: {
            type: type.DATEONLY,
            allowNull: false
        },
        note: {
            type: type.TEXT,
            allowNull: false
        },
        attachment: {
            type: type.STRING,
            allowNull: true
        },
        primary_status: {
            type: type.INTEGER,
            allowNull: true
        },
        admin_status: {
            type: type.INTEGER,
            allowNull: true
        },
        backup_status: {
            type: type.INTEGER,
            allowNull: true
        },
        primary_approver: {
            type: type.INTEGER,
            allowNull: true
        },
        backup_approver: {
            type: type.INTEGER,
            allowNull: true
        },
        _token: {
            type: type.STRING,
            allowNull: true
        },
        document: {
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