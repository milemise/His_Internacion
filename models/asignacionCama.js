'use strict';
module.exports = (sequelize, DataTypes) => {
    const AsignacionCama = sequelize.define('AsignacionCama', {
        id_asignacion_cama: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        id_admision: {
            type: DataTypes.INTEGER,
            allowNull: false
        },
        id_cama: {
            type: DataTypes.INTEGER,
            allowNull: false
        },
        fecha_asignacion: {
            type: DataTypes.DATE,
            allowNull: false
        },
        fecha_liberacion: DataTypes.DATE,
        es_actual: {
            type: DataTypes.BOOLEAN,
            defaultValue: true
        }
    }, {
        tableName: 'asignacion_cama',
        timestamps: false
    });

    return AsignacionCama;
};