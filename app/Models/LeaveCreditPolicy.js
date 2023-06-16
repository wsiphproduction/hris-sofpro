module.exports = (sequelize, type) => {
    return sequelize.define('leave_credit_policy', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false
        },
        policy_id: {
            type: type.INTEGER,
            allowNull: false
        },
        balance: {
            type: type.FLOAT,
            allowNull: true,
        },
        utilized: {
            type: type.FLOAT,
            allowNull: true,
            
        },
        cycle: {
            type: type.DATEONLY,
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