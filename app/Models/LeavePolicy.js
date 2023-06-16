module.exports = (sequelize, type) => {
    return sequelize.define('leave_policy', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        name: {
            type: type.STRING,
            allowNull: false
        },
        code: {
            type: type.STRING,
            allowNull: true
        },
        total_per_year: {
            type: type.INTEGER,
            allowNull: true
        },
        gender: {
            type: type.STRING,
            allowNull: true
        },
        probation_validity: {
            type: type.INTEGER,
            allowNull: true
        },
        initial: {
            type: type.INTEGER,
            allowNull: true
        },
        cycle: {
            type: type.INTEGER,
            allowNull: true
        },
        carry_over: {
            type: type.INTEGER,
            allowNull: true
        },
        increment: {
            type: type.INTEGER,
            allowNull: true
        },
        max_increment: {
            type: type.INTEGER,
            allowNull: true
        },
        status: {
            type: type.INTEGER,
            allowNull: true
        },
        company: {
            type: type.INTEGER,
            allowNull: true
        },
        department: {
            type: type.INTEGER,
            allowNull: true
        },
        description: {
            type: type.TEXT,
            allowNull: true
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