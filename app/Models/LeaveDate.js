module.exports = (sequelize, type) => {
    return sequelize.define('leaves_date', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false
        },
        leave_id: {
            type: type.INTEGER,
            allowNull: false
        },
        date: {
            type: type.DATEONLY,
            allowNull: false
        },
        number_of_day: {
            type: type.FLOAT,
            allowNull: false
        },
        leave_duration: {
            type: type.INTEGER,
            allowNull: false
        },
        credit: {
            type: type.STRING,
            allowNull: true
        },
        date_is_filed: {
            type: type.INTEGER,
            allowNull: false,
            defaultValue: 1
        },
    },
    {
        freezeTableName: true,
        timestamps: false
    });
}