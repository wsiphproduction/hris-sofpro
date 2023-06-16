module.exports = (sequelize, type) => {
    return sequelize.define('configuration', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        json: {
            type: type.TEXT,
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