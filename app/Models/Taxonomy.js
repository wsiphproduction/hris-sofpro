module.exports = (sequelize, type) => {
    return sequelize.define('taxonomy', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        parent_id: {
            type: type.INTEGER,
            allowNull: false,
            defaultValue: 0
        },
        title: {
            type: type.STRING,
            allowNull: false
        },
        code: {
            type: type.STRING,
            allowNull: true
        },
        description: {
            type: type.TEXT,
            allowNull: true
        },
        status: {
            type: type.INTEGER,
            allowNull: false,
            defaultValue: 1
        },
        node: {
            type: type.INTEGER,
            allowNull: true
        },
        system_role: {
            type: type.INTEGER,
            allowNull: false,
            defaultValue: 0
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