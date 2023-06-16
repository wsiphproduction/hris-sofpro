module.exports = (sequelize, type) => {
    return sequelize.define('loan', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false
        },
        amount: {
            type: type.FLOAT,
            allowNull: true
        },
        label: {
            type: type.STRING,
            allowNull: false
        },
        mode_of_payment: {
            type: type.STRING,
            allowNull: true,
            comment: '0-cash, 1-Salary Deduction'
        },
        date_to_pay: {
            type: type.DATEONLY,
            allowNull: true,
            
        },
        frequency: {
            type: type.INTEGER,
            allowNull: true
        },
        year: {
            type: type.STRING,
            allowNull: true
        },
        month: {
            type: type.STRING,
            allowNull: true
        },
        period: {
            type: type.STRING,
            allowNull: true
        },
        status: {
            type: type.INTEGER,
            allowNull: true,
            comment: '0-Processing, 1-Approved, 2 = Complete'
        },
        loan_type: {
            type: type.INTEGER,
            allowNull: true,
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