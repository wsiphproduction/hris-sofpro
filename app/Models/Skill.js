module.exports = (sequelize, type) => {
    return sequelize.define('skill', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type:  type.INTEGER,
            allowNull: false
        },
        skill: {
            type:  type.STRING,
            allowNull: false
        },
        remark: {
            type:  type.STRING,
            allowNull:true
        },
        status: {
            type:  type.STRING, // 1 = 'Active', 2 = 'Archived'
            allowNull:true
        },
    },
    {
        freezeTableName: true,
    })
}
