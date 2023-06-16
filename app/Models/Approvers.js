module.exports = (sequelize, type) => {
    return sequelize.define('approvers', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        company_location_id: {
            type: type.INTEGER,
            allowNull: false
        },
        department_id: {
            type: type.INTEGER,
            allowNull: false
        },
        primary_approver_id: {
            type: type.INTEGER,
            allowNull: true
        },
        backup_approver_id: {
            type: type.INTEGER,
            allowNull: true
        },
        created_by: {
            type: type.INTEGER,
            allowNull: true
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