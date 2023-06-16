const SequelizeSlugify = require('sequelize-slugify');

module.exports = (sequelize, type) => {
    return sequelize.define('payslips', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false
        },
        payroll_period: {
            type: type.STRING,
            allowNull: true
        },
        employee_number: {
            type: type.STRING,
            allowNull: true
        },
        employee_name: {
            type: type.STRING,
            allowNull: true
        },
        monthly_rate: {
            type: type.FLOAT,
            allowNull: true
        },
        this_pay: {
            type: type.FLOAT,
            allowNull: true
        },
        absence: {
            type: type.FLOAT,
            allowNull: true
        },
        overtime_hrs: {
            type: type.FLOAT,
            allowNull: true
        },
        amount: {
            type: type.FLOAT,
            allowNull: true
        },
        gross_pay: {
            type: type.FLOAT,
            allowNull: true
        },
        reimburseable_allowance: {
            type: type.FLOAT,
            allowNull: true
        },
        other_fees_allowances: {
            type: type.FLOAT,
            allowNull: true
        },
        total_pay: {
            type: type.FLOAT,
            allowNull: true
        },
        tax: {
            type: type.FLOAT,
            allowNull: true
        },
        sss30th: {
            type: type.FLOAT,
            allowNull: true
        },
        phic30th: {
            type: type.FLOAT,
            allowNull: true
        },
        pagibig30th: {
            type: type.FLOAT,
            allowNull: true
        },
        other_deductions: {
            type: type.FLOAT,
            allowNull: true
        },
        sss_loan15th: {
            type: type.FLOAT,
            allowNull: true
        },
        pagibig_loan15th: {
            type: type.FLOAT,
            allowNull: true
        },
        employee_charges: {
            type: type.FLOAT,
            allowNull: true
        },
        intellicare: {
            type: type.FLOAT,
            allowNull: true
        },
        net_pay: {
            type: type.FLOAT,
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