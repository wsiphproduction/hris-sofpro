module.exports = (sequelize, type) => {
    return sequelize.define('shift_type', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        shift_id: {
            type: type.STRING,
            allowNull: true
        },
        shift_desc: {
            type: type.STRING,
            allowNull: true
        },
        shift_opt: {
            type: type.STRING,
            allowNull: true
        },
        credit_time_in: {
            type: type.TIME,
            allowNull: true
        },
        credit_time_out: {
            type: type.TIME,
            allowNull: true
        },
        time_in: {
            type: type.TIME,
            allowNull: true
        },
        time_out: {
            type: type.TIME,
            allowNull: true
        },
        gp: {
            type: type.INTEGER,
            allowNull: true
        },
        break_in: {
            type: type.TIME,
            allowNull: true
        },
        break_out: {
            type: type.TIME,
            allowNull: true
        },
        num_hours: {
            type: type.INTEGER,
            allowNull: true
        },
        cbamin: {
            type: type.TIME,
            allowNull: true
        },
        cbamout: {
            type: type.TIME,
            allowNull: true
        },
        cbpmin: {
            type: type.TIME,
            allowNull: true
        },
        cbpmout: {
            type: type.TIME,
            allowNull: true
        },
        trig_late: {
            type: type.TIME,
            allowNull: true
        },
        trig_under: {
            type: type.TIME,
            allowNull: true
        },
        early_in: {
            type: type.TIME,
            allowNull: true
        },
        early_out: {
            type: type.TIME,
            allowNull: true
        },
        late_in: {
            type: type.TIME,
            allowNull: true
        },
        late_out: {
            type: type.TIME,
            allowNull: true
        },
        flex_am_break: {
            type: type.INTEGER,
            allowNull: true
        },
        flex_pm_break: {
            type: type.INTEGER,
            allowNull: true
        },
        flex_break: {
            type: type.INTEGER,
            allowNull: true
        },
        min_ot: {
            type: type.INTEGER,
            allowNull: true
        },
        hday_by_late: {
            type: type.INTEGER,
            allowNull: true
        },
        ot_type: {
            type: type.STRING,
            allowNull: true
        },
        break_hours: {
            type: type.INTEGER,
            allowNull: true
        },
        seq_id: {
            type: type.INTEGER,
            allowNull: true
        },
        gp2: {
            type: type.INTEGER,
            allowNull: true
        },
        trig_absent: {
            type: type.STRING,
            allowNull: true
        },
        min_workhours_1h: {
            type: type.INTEGER,
            allowNull: true
        },
        min_workhours_2h: {
            type: type.INTEGER,
            allowNull: true
        },
        created_by: {
            type: type.INTEGER,
            allowNull: true
        },
        updated_by: {
            type: type.INTEGER,
            allowNull: true
        },
        created_terminal: {
            type: type.INTEGER,
            allowNull: true
        }, 
        updated_terminal: {
            type: type.INTEGER,
            allowNull: true
        },
        deletedAt: {
            type: type.DATE,
            allowNull: true,
            defaultValue: null,
        },
        status: {
            type: type.INTEGER,
            allowNull: false
        },
        is_from_previous: {
            type: type.INTEGER,
            defaultValue: 0,
            allowNull: false
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
    },
    {
        freezeTableName: true,
        timestamps: true
    });
}