module.exports = (sequelize, type) => {
    return sequelize.define('holidays', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        country_id: {
            type: type.INTEGER,
            allowNull: true
        },
        location_id: {
        	type: type.STRING,
        	allowNull: true
        },
        date: {
            type: type.DATEONLY,
            allowNull: false
        },
        title: {
            type: type.STRING,
            allowNull: false
        },
        type: {
            type: type.INTEGER,
            allowNull: false
        },
        status: {
            type: type.INTEGER,
            allowNull: true
        },
        note: {
            type: type.TEXT,
            allowNull: true
        },
        created_by: {
            type: type.INTEGER,
            allowNull: true,
            defaultValue: 0
        },
        updated_by: {
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