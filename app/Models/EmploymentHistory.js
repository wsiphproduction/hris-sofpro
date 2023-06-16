module.exports = (sequelize, type) => {
    return sequelize.define('employment_history', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false,
        },
        address_id: {
            type: type.INTEGER,
            allowNull: true,
        },
        company: {
            type: type.STRING,
            allowNull: true
        },
        position: {
            type: type.STRING,
            allowNull: true
        },
        reason_of_leaving: {
            type: type.BOOLEAN,
            allowNull: true,
        },
        date_started: {
            type: type.DATEONLY,
            allowNull: true,
            defaultValue: ''
        },
        date_ended: {
            type: type.DATEONLY,
            allowNull: true,
            defaultValue: ''

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