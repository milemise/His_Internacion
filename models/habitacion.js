'use strict';
module.exports = (sequelize, DataTypes) => {
    const Habitacion = sequelize.define('Habitacion', {
        id_habitacion: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        numero: {
            type: DataTypes.STRING(10),
            allowNull: false
        },
        tipo: {
            type: DataTypes.ENUM('Individual', 'Compartida', 'Suite'),
            allowNull: false
        },
        estado: {
            type: DataTypes.ENUM('Disponible', 'Ocupada', 'Mantenimiento', 'Limpieza'),
            defaultValue: 'Disponible'
        },
        id_ala: {
            type: DataTypes.INTEGER,
            allowNull: false
        }
    }, {
        tableName: 'habitaciones',
        timestamps: false
    });
    Habitacion.associate = function(models) {
        Habitacion.belongsTo(models.Ala, { foreignKey: 'id_ala' });
        Habitacion.hasMany(models.Cama, { foreignKey: 'id_habitacion' });
    };
    return Habitacion;
};