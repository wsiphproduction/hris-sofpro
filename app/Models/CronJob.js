module.exports = (sequelize, type) => {
    return sequelize.define('cron_job', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        status: {
            type: type.INTEGER,
            allowNull: false
        },
        target_date: {
            type: type.DATEONLY,
            allowNull: false
        },
        datetime_initiated: {
            type: 'TIMESTAMP',
            allowNull: false
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