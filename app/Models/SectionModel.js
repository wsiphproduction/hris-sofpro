module.exports = (sequelize, type) => {
    return sequelize.define('sections', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        department_id: {
            type: type.INTEGER,
            allowNull: false
        },
        section_name: {
            type: type.STRING,
            allowNull: false
        },
        section_code: {
            type: type.STRING,
            allowNull: false
        },
        supervisor_id: {
            type: type.INTEGER,
            allowNull: false
        },
        assistant_supervisor_id: {
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