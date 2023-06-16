module.exports = (sequelize, type) => {
    return sequelize.define('two_factor_authentication', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false
        },
        status: {
            type: type.INTEGER,
            allowNull: true
        },
        code: {
            type: type.STRING,
            allowNull: true
        },
        validity_date: {
            type: type.DATE,
            allowNull: true
        },
    },
    {
        freezeTableName: true,
    	timestamps: false
    });
}