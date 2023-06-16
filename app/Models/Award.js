module.exports = (sequelize, type) => {
    return sequelize.define('award', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type:  type.INTEGER,
            allowNull: false
        },
        title: {
            type:  type.STRING,
            allowNull: false,
        },
        date: {
            type: type.DATEONLY,
            allowNull: true,
        },
        given_by: {
            type: type.STRING,
            allowNull: false
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
