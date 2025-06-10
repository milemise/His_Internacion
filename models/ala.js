'use strict';
module.exports = (sequelize, DataTypes) => {
    const Ala = sequelize.define('Ala', {
        id_ala: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        nombre: {
            type: DataTypes.STRING(100),
            allowNull: false
        }
    }, {
        tableName: 'ala',
        timestamps: false
    });
    Ala.associate = function(models) {
        Ala.hasMany(models.Habitacion, { foreignKey: 'id_ala' });
    };
    return Ala;
};