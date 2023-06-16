module.exports = (sequelize, type) => {
    return sequelize.define('branding', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        name: {
            type: type.STRING,
            allowNull: true
        },
        logo: {
            type: type.STRING,
            allowNull: true
        },
        branding: {
            type: type.INTEGER,
            allowNull: true
        }
    },
    {
        freezeTableName: true,
        timestamps: false
    });
}