module.exports = (sequelize, type) => {
    return sequelize.define('salary', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false
        },
        start_date: {
            type: type.DATEONLY,
            allowNull: false
        },
        end_date: {
            type: type.DATEONLY,
            allowNull: true
        },
        amount: {
            type: type.FLOAT,
            allowNull: true
        },
        mode: {
            type: type.INTEGER,
            allowNull: true,
            comment: '0=Per Month 1=Per Week 2=Per Day 3=Per Hour'
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