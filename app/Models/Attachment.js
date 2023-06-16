module.exports = (sequelize, type) => {
    return sequelize.define('attachments', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.STRING,
            allowNull: false
        },
        attachment: {
            type: type.STRING,
            allowNull: true
        },
        description: {
            type: type.TEXT,
            allowNull: true
        },
        document_number: {
            type: type.STRING,
            allowNull: true
        },
        place_of_issue: {
            type: type.STRING,
            allowNull: true
        },
        document_type: {
            type: type.STRING,
            allowNull: true
        },
        remarks: {
            type: type.TEXT,
            allowNull: true
        },
        status: {
            type:  type.STRING, // 1 = 'Active', 2 = 'Archived'
            allowNull:true
        },
        created_at: {
            type: 'Datetime',
            allowNull: false,
            defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
        },
        updated_time: {
            type: 'Datetime',
            allowNull: true,
            defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
        },
    },
    {
        freezeTableName: true,
    	timestamps: false,
    });
}