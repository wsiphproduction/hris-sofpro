module.exports = (sequelize, type) => {
    return sequelize.define('users_role', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        role_id: {
            type: type.INTEGER,
            allowNull: false
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false
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