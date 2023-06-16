module.exports = (sequelize, type) => {
    return sequelize.define('locations', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        location: {
            type: type.STRING,
            allowNull: false
        },
        createdAt: {
            type: 'TIMESTAMP',
            allowNull: false,
            defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
        },
        updatedAt: {
            type: 'TIMESTAMP',
            allowNull: false,
            defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
        },
    },
    {
        freezeTableName: true,
    	timestamps: true
    });
}