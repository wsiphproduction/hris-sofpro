module.exports = (sequelize, type) => {
    return sequelize.define('custom_approver', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.STRING,
            allowNull: false
        },
        primary_approver_id: {
            type: type.STRING,
            allowNull: true
        },
        backup_approver_id: {
            type: type.STRING,
            allowNull: true
        }
    },
    {
        freezeTableName: true,
    	timestamps: false
    });
}