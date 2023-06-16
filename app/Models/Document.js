module.exports = (sequelize, type) => {
    return sequelize.define('users_document', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false
        },
        label: {
            type: type.STRING,
            allowNull: false
        },
        hash: {
            type: type.STRING,
            allowNull: true
        },
        original_name: {
            type: type.STRING,
            allowNull: true
        },
        description: {
            type: type.TEXT,
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