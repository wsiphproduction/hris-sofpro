module.exports = (sequelize, type) => {
    return sequelize.define('user_setting', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false
        },
        has_holiday: {
            type: type.INTEGER,
            allowNull: true
        },
        has_overtime: {
            type: type.INTEGER,
            allowNull: true
        },
        work_schedule_method: {
            type: type.INTEGER,
            allowNull: true
        },
    },
    {
        freezeTableName: true,
        timestamps: false
    });
}