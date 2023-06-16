module.exports = (sequelize, type) => {
    return sequelize.define('countries', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        iso: {
            type: type.STRING,
            allowNull: false
        },
        name: {
            type: type.STRING,
            allowNull: false
        },
        code: {
            type: type.STRING,
            allowNull: true
        }
    },
    {
        freezeTableName: true,
    	timestamps: false
    });
}