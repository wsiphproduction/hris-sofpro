module.exports = (sequelize, type) => {
    return sequelize.define('family_background', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false,
        },
        permanent_address_id: {
            type: type.INTEGER,
            allowNull: true,
        },
        first_name: {
            type: type.STRING,
            allowNull: true
        },
        middle_name: {
            type: type.STRING,
            allowNull: true
        },
        last_name: {
            type: type.STRING,
            allowNull: true
        },
        relationship: {
            type: type.STRING,
            allowNull: true
        },
        contact_number: {
            type: type.STRING,
            allowNull: true
        },
        birthdate: {
            type: type.DATEONLY,
            allowNull: true,
        },
        age: {
            type: type.STRING,
            allowNull: true,
        },
        occupation: {
            type: type.STRING,
            allowNull: true,
        },
        assign_as_dependent: {
            type: type.BOOLEAN,
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
    },
    {
        freezeTableName: true,
    	timestamps: false
    });
}