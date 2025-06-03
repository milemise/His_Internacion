const Paciente = require('../models/paciente');

// Exportar funciones con `exports.`
exports.listarPacientes = async (req, res) => {
  const pacientes = await Paciente.findAll();
  res.render('pacientes/index', { pacientes });
};

exports.formularioNuevo = (req, res) => {
  res.render('pacientes/nuevo');
};

exports.guardarPaciente = async (req, res) => {
  await Paciente.create(req.body);
  res.redirect('/pacientes');
};

exports.mostrarFormularioEditar = async (req, res) => {
  const id = req.params.id;
  const paciente = await Paciente.findByPk(id);
  if (!paciente) return res.status(404).send('Paciente no encontrado');
  res.render('pacientes/editar', { paciente });
};

exports.editarPaciente = async (req, res) => {
  const id = req.params.id;
  const { nombre, telefono, direccion, fecha_nacimiento, obra_social, sexo, contacto_emergencia } = req.body;
  await Paciente.update({ nombre, telefono, direccion, fecha_nacimiento, obra_social, sexo, contacto_emergencia }, { where: { id } });
  res.redirect('/pacientes');
};