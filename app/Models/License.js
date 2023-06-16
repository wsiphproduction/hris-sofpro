module.exports = (sequelize, type) => {
    return sequelize.define('license', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type:  type.INTEGER,
            allowNull: false
        },
        license: {
            type:  type.STRING,
            allowNull: false,
        },
        description: {
            type:  type.STRING,
            allowNull: false,
        },
        date_issued: {
            type: type.DATEONLY,
            allowNull: true,
        },
        expiration: {
            type: type.DATEONLY,
            allowNull: true,
        },
        start_date: {
            type: type.DATEONLY,
            allowNull: true,
        },
        end_date: {
            type: type.DATEONLY,
            allowNull: true,
        },
        status: {
            type:  type.STRING, // 1 = 'Active', 2 = 'Archived'
            allowNull:true
        },
    },
    {
        freezeTableName: true,
        timestamps: true,
    })
}
