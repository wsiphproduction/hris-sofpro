module.exports = (sequelize, type) => {
    return sequelize.define('biometrics', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        label: {
            type: type.STRING,
            allowNull: true
        },
        site: {
            type: type.STRING,
            allowNull: true
        },
        status: {
            type: type.INTEGER,
            allowNull: false
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