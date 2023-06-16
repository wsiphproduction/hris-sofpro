const SequelizeSlugify = require('sequelize-slugify');

module.exports = (sequelize, type) => {
    return sequelize.define('payroll', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        period: {
            type: type.STRING,
            allowNull: true
        },
        attachment: {
            type: type.STRING,
            allowNull: true
        },
        date: {
            type: type.DATE,
            allowNull: true
        },
        rate_type: {
            type: type.STRING, //0 = 'Daily', 1 = 'Monthly'
            allowNull: false
        },
        payee_location: {
            type: type.STRING,
            allowNull: false
        },
        payment_type: {
            type: type.STRING,
            allowNull: false,
            defaultValue: 0 //0 = 'CASH', 1 = 'ATM'
        },
        currency_id: {
            type: type.STRING,
            allowNull: false,
            defaultValue: 'Peso(Php)'
        },
        bank_id: {
            type: type.STRING,
            allowNull: false,  
        },
        bank_name: {
            type: type.STRING,
            allowNull: false,
            defaultValue: 'Peso(Php)'
        },
        bank_acct_number: {
            type: type.STRING,
            allowNull: false,
        },
        basic_monthly_rate: {
            type: type.DECIMAL,
            allowNull: false,
        },
        basic_daily_rate: {
            type: type.DECIMAL,
            allowNull: false,
        },
        e_cola_daily: {
            type: type.DECIMAL,
            allowNull: true,
        },
        allowance: {
            type: type.STRING,
            allowNull: true,
        },
        allowance_effective_date: {
            type: type.DATEONLY,
            allowNull: true,
        },
        incentive: {
            type: type.STRING,
            allowNull: true,
        },
        incentive_effective_date: {
            type: type.DATEONLY,
            allowNull: true,
        },
        benefit: {
            type: type.STRING,
            allowNull: true,
        },
        benefit_effective_date: {
            type: type.DATEONLY,
            allowNull: true,
        },
    },
    {
        freezeTableName: true,
    	timestamps: false
    });
}