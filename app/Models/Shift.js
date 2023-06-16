module.exports = (sequelize, type) => {
    return sequelize.define('shifts', {
        id: {
            type: type.BIGINT,
            primaryKey: true,
            autoIncrement: true
        },
        user_id: {
            type: type.INTEGER,
            allowNull: false
        },
        type: {
            type: type.INTEGER,
            allowNull: true
        },
        date: {
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
        actual_check_in: {
            type: type.TIME,
            allowNull: true
        },
        actual_check_out: {
            type: type.TIME,
            allowNull: true
        },
        new_checkin: {
            type: type.DATE,
            allowNull: true
        },
        new_checkout: {
            type: type.DATE,
            allowNull: true
        },
        old_checkin: {
            type: type.DATE,
            allowNull: true
        },
        old_checkout: {
            type: type.DATE,
            allowNull: true
        },
        primary_status: {
            type: type.INTEGER,
            allowNull: true
        },
        attachment: {
            type: type.STRING,
            allowNull: true
        },
        shift_length: {
            type: type.INTEGER,
            allowNull: true
        },
        // paid_hours: {
        //     type: type.INTEGER,
        //     allowNull: true
        // },
        primary_approver: {
            type: type.INTEGER,
            allowNull: true
        },
        // backup_approver: {
        //     type: type.INTEGER,
        //     allowNull: true
        // },
        // approver_note: {
        //     type: type.TEXT,
        //     allowNull: true
        // },
        // onsite: {
        //     type: type.INTEGER,
        //     allowNull: true
        // },
        // _token: {
        //     type: type.STRING,
        //     allowNull: true
        // },

        reg_holiday_work_hrs: {
            type: type.INTEGER,
            allowNull: true
        },
        reg_holiday_rest_day_work_hrs: {
            type: type.INTEGER,
            allowNull: true
        },
        reg_special_holiday_restday_work_hrs: {
            type: type.INTEGER,
            allowNull: true
        },
        double_reg_holiday: {
            type: type.INTEGER,
            allowNull: true
        },
        special_holiday: {
            type: type.INTEGER,
            allowNull: true
        },
        special_holiday_restday: {
            type: type.INTEGER,
            allowNull: true
        },
        reg_special_holiday: {
            type: type.INTEGER,
            allowNull: true
        },
        late: {
            type: type.INTEGER,
            allowNull: true
        },
        undertime: {
            type: type.INTEGER,
            allowNull: true
        },
        absent: {
            type: type.INTEGER,
            allowNull: true
        },
        awol: {
            type: type.INTEGER,
            allowNull: true
        },
        actual_work_hours: {
            type: type.INTEGER,
            allowNull: true
        },
        is_restday: {
            type: type.INTEGER,
            allowNull: true
        },
        night_diff: {
            type: type.INTEGER,
            allowNull: true
        },
        is_change_shift: {
            type: type.INTEGER,
            allowNull: true
        },
        shift_type: {
            type: type.STRING,
            allowNull: true
        },
        new_shift_type: {
            type: type.STRING,
            allowNull: true
        },
        secretary_id: {
            type: type.INTEGER,
            allowNull: true
        },
        break_hour: {
            type: type.INTEGER,
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