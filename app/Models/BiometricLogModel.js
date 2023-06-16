module.exports = (sequelize, type) => {
    return sequelize.define('biometric_logs', {
        id: {
            type: type.BIGINT,
            primaryKey: true,
            autoIncrement: true
        },
        userId: {
            type: type.INTEGER,
            allowNull: false
        },
        state: {
            type: type.INTEGER,
            allowNull: true
        },
        ip_address: {
            type: type.STRING,
            allowNull: true
        },
        date: {
            type: type.DATE,
            allowNull: true
        },
        status: {
            type: type.INTEGER,
            allowNull: true
        },
        source: {
            type: type.STRING,
            allowNull: true
        },
    },
    {
        freezeTableName: true,
    	timestamps: false
    });
}