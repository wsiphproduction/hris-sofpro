module.exports = (sequelize, type) => {
    return sequelize.define('performance_review', {
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
        evaluation_date: {
            type: type.DATEONLY,
            allowNull: true,
        },
        evaluator: {
            type: type.STRING,
            allowNull: false
        },
        rating: {
            type:  type.STRING,
            allowNull:true
        },
        recommendation: {
            type:  type.STRING,
            allowNull:true
        },
        remarks: {
            type:  type.STRING,
            allowNull:true
        },
        points: {
            type:  type.INTEGER,
            allowNull:true
        },
        description: {
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
        timestamps: true,
    })
}
