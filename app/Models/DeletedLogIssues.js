module.exports = (sequelize, type) => {
    return sequelize.define('deleted_log_issues', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        date: {
            type: type.DATEONLY,
            allowNull: false
        },
        shift_id: {
            type: type.INTEGER,
            allowNull: false,
        },
        status: {
            type: type.INTEGER,
            defaultValue: 1,
            allowNull: false,
        }
    },
    {
        freezeTableName: true,
        timestamps: false
    });
}