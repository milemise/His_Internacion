const Paciente = require('../models/paciente');

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