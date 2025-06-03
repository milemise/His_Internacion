const { DataTypes } = require('sequelize');
const sequelize = require('./sequelize');

const Paciente = sequelize.define('Paciente', {
    nombre: DataTypes.STRING,
    apellido: DataTypes.STRING,
    dni: DataTypes.STRING,
    fecha_nacimiento: DataTypes.DATEONLY
});

module.exports = Paciente;