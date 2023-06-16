module.exports = (sequelize, type) => {
    return sequelize.define('notification', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        sender: {
            type: type.INTEGER,
            allowNull: false
        },
        content: {
            type: type.TEXT,
            allowNull: false
        },
        url: {
            type: type.STRING,
            allowNull: true
        },
        date: {
            type: 'TIMESTAMP',
            allowNull: false,
            defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
        },
        created_by: {
            type: type.INTEGER,
            allowNull: true,
            defaultValue: 0
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