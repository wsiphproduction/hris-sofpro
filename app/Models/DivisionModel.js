module.exports = (sequelize, type) => {
    return sequelize.define('divisions', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        company_id: {
            type: type.INTEGER,
            allowNull: false
        },
        name: {
            type: type.STRING,
            allowNull: false
        },
        code: {
            type: type.STRING,
            allowNull: true
        },
        manager_id: {
            type: type.INTEGER,
            allowNull: true
        },
        assistant_manager_id: {
            type: type.INTEGER,
            allowNull: true
        },
        secretary_id: {
            type: type.INTEGER,
            allowNull: true
        },
        alternate_secretary: {
            type: type.INTEGER,
            allowNull: true
        },
        description: {
            type: type.TEXT,
            allowNull: false
        },
        status: {
            type: type.INTEGER,
            allowNull: false
        },
        deletedAt: {
            type: type.DATE,
            allowNull: true,
            defaultValue: null,
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