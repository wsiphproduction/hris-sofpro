module.exports = (sequelize, type) => {
    return sequelize.define('events', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false
        },
        date: {
            type: type.DATE,
            allowNull: false
        },
        end_date: {
            type: type.DATE,
            allowNull: true
        },
        type: {
            type: type.STRING,
            allowNull: false
        },
        comment: {
            type: type.STRING,
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