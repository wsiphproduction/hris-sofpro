module.exports = (sequelize, type) => {
    return sequelize.define('leave_credits', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false
        },
        allocated_el: {
            type: type.FLOAT,
            allowNull: true
        },
        allocated_vl: {
            type: type.FLOAT,
            allowNull: true
        },
        allocated_sl: {
            type: type.FLOAT,
            allowNull: true
        },
        allocated_offset: {
            type: type.FLOAT,
            allowNull: true
        },
        available_el: {
            type: type.FLOAT,
            allowNull: true
        },
        available_vl: {
            type: type.FLOAT,
            allowNull: true
        },
        available_sl: {
            type: type.FLOAT,
            allowNull: true
        },
        available_offset: {
            type: type.FLOAT,
            allowNull: true
        },

        addition_el: {
            type: type.FLOAT,
            allowNull: true
        },
        addition_vl: {
            type: type.FLOAT,
            allowNull: true
        },
        addition_sl: {
            type: type.FLOAT,
            allowNull: true
        },
        addition_offset: {
            type: type.FLOAT,
            allowNull: true
        },

        max_el: {
            type: type.FLOAT,
            allowNull: true
        },
        max_vl: {
            type: type.FLOAT,
            allowNull: true
        },
        max_sl: {
            type: type.FLOAT,
            allowNull: true
        },
        max_offset: {
            type: type.FLOAT,
            allowNull: true
        },

        reset_date: {
            type: type.DATEONLY,
            allowNull: true
        },
        created_by: {
            type: type.INTEGER,
            allowNull: true,
            defaultValue: 0
        },
        updated_by: {
            type: type.INTEGER,
            allowNull: true,
            defaultValue: 0
        },
        created_at: {
            type: 'TIMESTAMP',
            allowNull: false,
            defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
        },
        updated_at: {
            type: 'TIMESTAMP',
            allowNull: false,
            defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
        },
    },
    {
        freezeTableName: true,
    	timestamps: false
    });
}