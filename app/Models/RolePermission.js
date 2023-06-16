module.exports = (sequelize, type) => {
    return sequelize.define('role_permission', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        role_id: {
            type: type.INTEGER,
            allowNull: true
        },
        module_tag: {
            type: type.CHAR,
            allowNull: true
        },
        read: {
            type: type.INTEGER,
            allowNull: true
        },
        write: {
            type: type.INTEGER,
            allowNull: true
        },
        modify: {
            type: type.INTEGER,
            allowNull: true
        },
        delete: {
            type: type.INTEGER,
            allowNull: true
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