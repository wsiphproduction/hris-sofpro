module.exports = (sequelize, type) => {
    return sequelize.define('tss_summary', {
        id: {
            type: type.BIGINT,
            primaryKey: true,
            autoIncrement: true
        },
        tss_id: {
            type: type.BIGINT,
            allowNull: false
        },
        user_id: {
            type: type.BIGINT,
            allowNull: false
        },
        RegHrs: {
            type: type.FLOAT,
            allowNull: true
        },
        LateHrs: {
            type: type.FLOAT,
            allowNull: true
        },
        UndertimeHrs: {
            type: type.FLOAT,
            allowNull: true
        },
        NDHrs: {
            type: type.FLOAT,
            allowNull: true
        },
        Absent: {
            type: type.FLOAT,
            allowNull: true
        },
        Leave01: {
            type: type.FLOAT,
            allowNull: true
        },
        Leave02: {
            type: type.FLOAT,
            allowNull: true
        },
        Leave03: {
            type: type.FLOAT,
            allowNull: true
        },
        Leave04: {
            type: type.FLOAT,
            allowNull: true
        },
        Leave05: {
            type: type.FLOAT,
            allowNull: true
        },
        Leave06: {
            type: type.FLOAT,
            allowNull: true
        },
        Leave07: {
            type: type.FLOAT,
            allowNull: true
        },
        Leave08: {
            type: type.FLOAT,
            allowNull: true
        },
        Leave09: {
            type: type.FLOAT,
            allowNull: true
        },
        Leave10: {
            type: type.FLOAT,
            allowNull: true
        },
        Leave11: {
            type: type.FLOAT,
            allowNull: true
        },
        Leave12: {
            type: type.FLOAT,
            allowNull: true
        },
        Leave13: {
            type: type.FLOAT,
            allowNull: true
        },
        Leave14: {
            type: type.FLOAT,
            allowNull: true
        },
        Leave15: {
            type: type.FLOAT,
            allowNull: true
        },
        Leave16: {
            type: type.FLOAT,
            allowNull: true
        },
        Leave17: {
            type: type.FLOAT,
            allowNull: true
        },
        Leave18: {
            type: type.FLOAT,
            allowNull: true
        },
        Leave19: {
            type: type.FLOAT,
            allowNull: true
        },
        Leave20: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs01: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs02: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs03: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs04: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs05: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs06: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs07: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs08: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs09: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs10: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs11: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs12: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs13: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs14: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs15: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs16: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs17: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs18: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs19: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs20: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs21: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs22: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs23: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs24: {
            type: type.FLOAT,
            allowNull: true
        },
        OTHrs25: {
            type: type.FLOAT,
            allowNull: true
        },
        Rate: {
            type: type.FLOAT,
            allowNull: true
        },
        UnpaidRegHrs: {
            type: type.FLOAT,
            allowNull: true
        },
        UnpaidSL: {
            type: type.FLOAT,
            allowNull: true
        },
        UnpaidTaxSL: {
            type: type.FLOAT,
            allowNull: true
        },
        UnpaidVL: {
            type: type.FLOAT,
            allowNull: true
        },
        UnpaidTaxVL: {
            type: type.FLOAT,
            allowNull: true
        },
        UnpaidEL: {
            type: type.FLOAT,
            allowNull: true
        },
        EffectivityDate: {
            type: type.INTEGER,
            allowNull: true
        },
        EmpStatus: {
            type: type.INTEGER,
            allowNull: true
        },
        EffectivityDateResign: {
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