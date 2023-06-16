module.exports = (sequelize, type) => {
    return sequelize.define('departments', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        division_id: {
            type: type.INTEGER,
            allowNull: false
        },
        department_name: {
            type: type.STRING,
            allowNull: false
        },
        department_code: {
            type: type.STRING,
            allowNull: false
        },
        manager_id: {
            type: type.INTEGER,
            allowNull: false
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
        hr_generalist_id: {
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