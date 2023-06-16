module.exports = (sequelize, type) => {
    return sequelize.define('branches', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        location_id: {
            type: type.INTEGER,
            allowNull: false
        },
        // location_name: {
        //     type: type.STRING,
        //     allowNull: true
        // },
        address: {
            type: type.STRING,
            allowNull: true
        },
        country_id: {
            type: type.STRING,
            allowNull: true
        },
        company_id: {
            type: type.STRING,
            allowNull: false
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