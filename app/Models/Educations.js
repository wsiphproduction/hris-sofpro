module.exports = (sequelize, type) => {
    return sequelize.define('educations', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false
        },
        school: {
            type: type.STRING,
            allowNull: true
        },
        degree: {
            type: type.STRING,
            allowNull: true
        },
        year_attended: {
            type: type.STRING,
            allowNull: true
        },
        post_graduate: {
            type: type.STRING,
            allowNull: true
        },
        others: {
            type: type.STRING,
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
        educational_attainment: {
            type: type.STRING,
            allowNull: true
        },
        date_from: {
            type: type.DATEONLY,
            allowNull: true,
            defaultValue: ''
        },
        date_to: {
            type: type.DATEONLY,
            allowNull: true,
            defaultValue: ''

        },
        course: {
            type: type.STRING,
            allowNull: true
        },
        specialization: {
            type: type.STRING,
            allowNull: true
        },
        honors: {
            type: type.STRING,
            allowNull: true
        },
    },
    {
        freezeTableName: true,
    	timestamps: false
    });
}