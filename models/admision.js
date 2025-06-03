const { DataTypes } = require('sequelize');
const sequelize = require('./sequelize');
const Paciente = require('./paciente');

const Admision = sequelize.define('Admision', {
    fecha_ingreso: DataTypes.DATE,
    motivo: DataTypes.STRING,
    pacienteId: {
        type: DataTypes.INTEGER,
        references: { model: Paciente, key: 'id' }
    }
});

Admision.belongsTo(Paciente, { foreignKey: 'pacienteId' });
Paciente.hasMany(Admision, { foreignKey: 'pacienteId' });

module.exports = Admision;