const SequelizeSlugify = require('sequelize-slugify');

module.exports = (sequelize, type) => {
    return sequelize.define('adjustment', {
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
            allowNull: false
        },
        month: {
            type: type.STRING,
            allowNull: false
        },
        period: {
            type: type.STRING,
            allowNull: true
        },
        amount: {
            type: type.FLOAT,
            allowNull: false
        },
        status: {
            type: type.INTEGER,
            allowNull: false
        },
        created_by: {
            type: type.INTEGER,
            allowNull: true
        },
        updated_by: {
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