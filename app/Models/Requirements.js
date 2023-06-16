module.exports = (sequelize, type) => {
    return sequelize.define('requirements', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        candidate_id: {
            type: type.INTEGER,
            allowNull: false
        },
        title: {
            type: type.STRING,
            allowNull: false
        },
        status: {
            type: type.INTEGER,
            allowNull: 1
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