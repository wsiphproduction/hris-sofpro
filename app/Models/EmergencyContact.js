module.exports = (sequelize, type) => {
    return sequelize.define('emergency_contact', {
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
            allowNull: false
        },
        middle_name: {
            type: type.STRING,
            allowNull: true
        },
        last_name: {
            type: type.STRING,
            allowNull: false
        },
        relationship: {
            type: type.STRING,
            allowNull: true
        },
        contact_number: {
            type: type.STRING,
            allowNull: true
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
    	timestamps: false
    });
}