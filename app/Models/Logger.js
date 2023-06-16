const SequelizeSlugify = require('sequelize-slugify');

module.exports = (sequelize, type) => {
    return sequelize.define('logs', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        date: {
            type: type.DATE,
            allowNull: false
        },
        message: {
            type: type.STRING,
            allowNull: true
        },
    },
    {
        freezeTableName: true,
    	timestamps: false
    });
}