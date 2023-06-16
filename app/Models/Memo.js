module.exports = (sequelize, type) => {
    return sequelize.define('memorandum', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type:  type.INTEGER,
            allowNull: false
        },
        memo: {
            type:  type.STRING,
            allowNull: false
        },
        subject: {
            type:  type.STRING,
            allowNull:true
        },
        description: {
            type: type.STRING,
            allowNull: false
        },
        date:{
            type: type.DATEONLY,
            allowNull: true,
        },
        issued_by: {
            type:  type.STRING,
            allowNull:true
        },
        issued_to: {
            type:  type.STRING,
            allowNull:true
        },
        effectivity_date:{
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
    })
}
