module.exports = (sequelize, type) => {
    return sequelize.define('incentive', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false
        },
        from: {
            type: type.DATEONLY,
            allowNull: true
        },
        to: {
            type: type.DATEONLY,
            allowNull: true
        },
        amount: {
            type: type.FLOAT,
            allowNull: true
        },
        label: {
            type: type.STRING,
            allowNull: true
        },
        mode: {
            type: type.INTEGER,
            allowNull: true,
            comment: '0-cash, 1-cheque, 2-salary addition'
        },
        status: {
            type: type.INTEGER,
            allowNull: true,
            comment: '0-Inactive, 1-Active'
        },
        period: {
            type: type.INTEGER,
            allowNull: true,
            comment: '0=A, 1=B, 3=50-50'
        },
        taxable: {
            type: type.INTEGER,
            allowNull: true,
            comment: '0=NO, 1=YES'
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