module.exports = (sequelize, type) => {
    return sequelize.define('business_trip_date', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        bid: {
            type: type.INTEGER,
            allowNull: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: true
        },
        date: {
            type: type.DATEONLY,
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