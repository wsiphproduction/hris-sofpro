module.exports = (sequelize, type) => {
    return sequelize.define('notification_receiver', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        notification_id: {
            type: type.INTEGER,
            allowNull: false
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false
        },
        status: {
            type: type.INTEGER,
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