const { Paciente } = require('./models');

console.log('--- Iniciando Test de Modelo Paciente ---');

if (Paciente) {
  console.log('Modelo "Paciente" cargado correctamente.');
  console.log('La clave primaria que Sequelize reconoce es:', Paciente.primaryKeyAttribute);
} else {
  console.log('🔴 Error: El modelo "Paciente" no se pudo cargar.');
}

console.log('--- Test Finalizado ---');