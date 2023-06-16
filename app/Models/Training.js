module.exports = (sequelize, type) => {
    return sequelize.define('training', {
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
            allowNull: true
        },
        description: {
            type: type.STRING,
            allowNull: true
        },
        classification:{
            type:  type.STRING,
            allowNull:true
        },
        training_type: {
            type:  type.STRING,
            allowNull:true
        },
        start_date: {
            type: type.DATEONLY,
            allowNull: true,
        },
        end_date: {
            type: type.DATEONLY,
            allowNull: true,
        },
        no_days: {
            type:  type.STRING,
            allowNull:true
        },
        training_provider: {
            type:  type.STRING,
            allowNull:true
        },
        address: {
            type:  type.STRING,
            allowNull:true
        },
        service_bound: {
            type:  type.STRING,
            allowNull:true
        },
        cdp_points: {
            type:  type.STRING,
            allowNull:true
        },
        training_cost: {
            type:  type.STRING,
            allowNull:true
        },
        training_venue: {
            type:  type.STRING,
            allowNull:true
        },
        evaluation_form: {
            type:  type.STRING,
            allowNull:true
        },
        training_report: {
            type:  type.STRING,
            allowNull:true
        },
        createdAt: {
        	type: 'TIMESTAMP',
        	allowNull: false,
        	defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
        },
        updatedAt: {
        	type: 'TIMESTAMP',
        	allowNull: false,
        	defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
        },
        status: {
            type:  type.STRING, // 1 = 'Active', 2 = 'Archived'
            allowNull:true
        },
    
    },
    {
        freezeTableName: true,
        timestamps: true
    })
}
