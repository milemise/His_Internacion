'use strict';
module.exports = (sequelize, DataTypes) => {
    const Turno = sequelize.define('Turno', {
        id_turno: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        id_paciente: DataTypes.INTEGER,
        id_medico: DataTypes.INTEGER,
        fecha_hora: {
            type: DataTypes.DATE,
            allowNull: false
        },
        estado: {
            type: DataTypes.ENUM('pendiente', 'confirmado', 'cancelado', 'finalizado'),
            defaultValue: 'pendiente'
        }
    }, {
        tableName: 'turnos',
        timestamps: false
    });
    Turno.associate = function(models) {
        Turno.belongsTo(models.Paciente, { foreignKey: 'id_paciente' });
    };
    return Turno;
};