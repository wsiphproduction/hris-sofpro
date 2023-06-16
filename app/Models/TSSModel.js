module.exports = (sequelize, type) => {
    return sequelize.define('tss', {
        id: {
            type: type.BIGINT,
            primaryKey: true,
            autoIncrement: true
        },
        label: {
            type: type.STRING,
            allowNull: false
        },
        start_date: {
            type: type.DATE,
            allowNull: false
        },
        end_date: {
            type: type.DATE,
            allowNull: false
        },
        month_year: {
            type: type.STRING,
            allowNull: true
        },
        period: {
            type: type.STRING,
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