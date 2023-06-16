module.exports = (sequelize, type) => {
    return sequelize.define('crm_clone', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        chase_id: {
            type: type.INTEGER,
            allowNull: false
        },
        sqm: {
            type: type.FLOAT,
            allowNull: true
        },
        reason: {
            type: type.TEXT,
            allowNull: true
        },
        flag: {
            type: type.INTEGER,
            allowNull: false
        },
        created_by: {
            type: type.INTEGER,
            allowNull: true
        },
        updated_by: {
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