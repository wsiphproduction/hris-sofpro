module.exports = (sequelize, type) => {
    return sequelize.define('biometric_csv', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        site: {
            type: type.INTEGER,
            allowNull: false
        },
        filename: {
            type: type.STRING,
            allowNull: false
        },
        date: {
            type: type.DATEONLY,
            allowNull: true
        },
    },
    {
        freezeTableName: true,
    	timestamps: false
    });
}