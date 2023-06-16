//var SequelizeSluggify = require('sequelize-sluggify');
const SequelizeSlugify = require('sequelize-slugify');

module.exports = (sequelize, type) => {
    const Role = sequelize.define('role', {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        
        slug: {
            type: type.STRING,
            unique: true
        },
        label: {
            type: type.STRING,
            allowNull: false,
            unique: true
        },
        status: {
            type: type.INTEGER,
            allowNull: false,
            defaultValue: 1
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

    SequelizeSlugify.slugifyModel(Role, {
        source: ['label'],
        slugOptions: { lower: true },
        overwrite: false,
        column: 'slug'
    });

    return Role;
}