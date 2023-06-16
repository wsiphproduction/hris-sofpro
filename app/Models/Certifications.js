module.exports = (sequelize, type) => {
    return sequelize.define('certifications', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false
        },
        name: {
            type: type.STRING,
            allowNull: true
        },
        description: {
            type: type.STRING,
            allowNull: true
        },
        date_issued: {
            type: type.DATEONLY,
            allowNull: true,
            defaultValue: ''
        },
        start_date: {
            type: type.DATEONLY,
            allowNull: true,
            defaultValue: ''
        },
        end_date: {
            type: type.DATEONLY,
            allowNull: true,
            defaultValue: ''
        },
        expiry_date: {
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
            allowNull: false,
            defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
        },
    },
    {
        freezeTableName: true,
    	timestamps: false
    });
}