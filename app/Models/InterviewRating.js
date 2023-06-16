module.exports = (sequelize, type) => {
    return sequelize.define('interview_ratings', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        interview_id: {
            type: type.INTEGER,
            allowNull: false
        },
        title: {
            type: type.TEXT,
            allowNull: false
        },
        candidate_rating: {
            type: type.INTEGER,
            allowNull: false
        },
        job_relevance: {
            type: type.INTEGER,
            allowNull: false
        },
        notes: {
            type: type.TEXT,
            allowNull: true
        },
    },
    {
        freezeTableName: true,
    	timestamps: false
    });
}