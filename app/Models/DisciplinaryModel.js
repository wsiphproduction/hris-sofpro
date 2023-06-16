module.exports = (sequelize, type) => {
    return sequelize.define('disciplinary_cases', {
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
            allowNull: false
        },
        incident_date: {
            type: type.DATEONLY,
            allowNull: true,
        },
        prepared_by: {
            type: type.STRING,
            allowNull: false
        },
        received_by:{
            type:  type.STRING,
            allowNull:false
        },
        code: {
            type:  type.STRING,
            allowNull:true
        },
        date_served: {
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
    })
}
