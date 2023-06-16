module.exports = (sequelize, type) => {
    return sequelize.define('interview', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        candidate_profile_id: {
            type: type.INTEGER,
            allowNull: false
        },
        interviewer: {
            type: type.INTEGER,
            allowNull: false
        },
        interview_date: {
            type: type.DATEONLY,
            allowNull: false
        },
        overall_assessment: {
            type: type.TEXT,
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