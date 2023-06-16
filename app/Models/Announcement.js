const SequelizeSlugify = require('sequelize-slugify');

module.exports = (sequelize, type) => {
    const Announcement = sequelize.define('announcement', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        subject: {
            type: type.STRING,
            allowNull: false
        },
        short_description: {
            type: type.TEXT,
            allowNull: false
        },
        description: {
            type: type.TEXT,
            allowNull: false
        },
        slug: {
            type: type.STRING,
            unique: true
        },
        created_by: {
            type: type.INTEGER,
            allowNull: false
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

    SequelizeSlugify.slugifyModel(Announcement, {
        source: ['subject'],
        slugOptions: { lower: true },
        overwrite: false,
        column: 'slug'
    });

    return Announcement;
}