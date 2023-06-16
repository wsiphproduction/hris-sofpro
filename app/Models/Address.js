module.exports = (sequelize, type) => {
    return sequelize.define('address', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        unit_building_residence_number: {
            type: type.STRING,
            allowNull: true,
        },
        street: {
            type: type.STRING,
            allowNull: true,
        },
        brgy: {
            type: type.STRING,
            allowNull: true,
        },
        city: {
            type: type.STRING,
            allowNull: true,
        },
        state_or_province: {
            type: type.STRING,
            allowNull: true,
        },
        region: {
            type: type.STRING,
            allowNull: true,
        },
        country: {
            type: type.STRING,
            allowNull: true,
        },
        zip_code: {
            type: type.STRING,
            allowNull: true,
        },
        created_at: {
            type: 'TIMESTAMP',
            allowNull: false,
            defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
        },
        updated_at: {
            type: 'TIMESTAMP',
            allowNull: true,
            defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
        },
        type: {
            type: type.STRING,
            allowNull: true,
        },
        user_id: {
            type: type.INTEGER,
            allowNull: true
        }
    },
    {
        freezeTableName: true,
    	timestamps: false
    });
}