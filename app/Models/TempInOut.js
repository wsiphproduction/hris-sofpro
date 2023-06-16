const SequelizeSlugify = require('sequelize-slugify');

module.exports = (sequelize, type) => {
    return sequelize.define('temp_in_out', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false
        },
        date: {
            type: type.DATEONLY,
            allowNull: false
        },
        time: {
            type: type.TIME,
            allowNull: false
        },
        type: {
            type: type.STRING,
            allowNull: false
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