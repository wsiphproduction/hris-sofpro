module.exports = (sequelize, type) => {
    return sequelize.define('crm_members', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        win_id: {
            type: type.INTEGER,
            allowNull: false
        },
        win_id: {
            type: type.INTEGER,
            allowNull: false
        },
    },
    {
        freezeTableName: true,
    	timestamps: false
    });
}