module.exports = (sequelize, type) => {
    return sequelize.define('loan_payments', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false
        },
        loan_id: {
            type: type.INTEGER,
            allowNull: false
        },
        year: {
            type: type.INTEGER,
            allowNull: false
        },
        month: {
            type: type.STRING,
            allowNull: true
        },
        period: {
            type: type.STRING,
            allowNull: true,
            
        },
        amount: {
            type: type.FLOAT,
            allowNull: true
        },
        status: {
            type: type.INTEGER,
            allowNull: true
        },
    },
    {
        freezeTableName: true,
        timestamps: false
    });
}