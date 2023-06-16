module.exports = (sequelize, type) => {
    return sequelize.define('work_schedule', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false
        },
        type: {
            type: type.INTEGER,
            allowNull: false
        },
        break_type: {
            type: type.INTEGER,
            allowNull: false
        },
		rooster_break: {
            type: type.INTEGER,
            allowNull: false
        },
		destination_entitlement: {
        	type: type.STRING,
        	allowNull: true
        },
		shift_type: {
            type: type.INTEGER,
            allowNull: false
        },
        effective_date: {
            type: type.DATEONLY,
            allowNull: false
        },
        check_in: {
            type: type.TIME,
            allowNull: true
        },
        check_out: {
            type: type.TIME,
            allowNull: true
        },
        between_start: {
            type: type.TIME,
            allowNull: true
        },
        between_end: {
            type: type.TIME,
            allowNull: true
        },
        shift_length: {
            type: type.INTEGER,
            allowNull: false
        },
        paid_hours: {
            type: type.INTEGER,
            allowNull: false
        },
        monday: {
            type: type.INTEGER,
            allowNull: true
        },
        tuesday: {
            type: type.INTEGER,
            allowNull: true
        },
        wednesday: {
            type: type.INTEGER,
            allowNull: true
        },
        thursday: {
            type: type.INTEGER,
            allowNull: true
        },
        friday: {
            type: type.INTEGER,
            allowNull: true
        },
        saturday: {
            type: type.INTEGER,
            allowNull: true
        },
        sunday: {
            type: type.INTEGER,
            allowNull: true
        },
        onsite: {
            type: type.INTEGER,
            allowNull: true
        },
        created_by: {
            type: type.INTEGER,
            allowNull: true
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