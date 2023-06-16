module.exports = (sequelize, type) => {
    return sequelize.define('crm_chase', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        account: {
            type: type.STRING,
            allowNull: false
        },
        project_site: {
            type: type.STRING,
            allowNull: false
        },
        type: {
            type: type.INTEGER,
            allowNull: false
        },
        revenue: {
            type: type.FLOAT,
            allowNull: false
        },
        sales: {
            type: type.STRING,
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