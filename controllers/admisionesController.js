const Admision = require('../models/admision');
const Paciente = require('../models/paciente');

exports.listarAdmisiones = async (req, res) => {
    const admisiones = await Admision.findAll({ include: Paciente });
    res.render('admisiones/index', { admisiones });
};

exports.formularioNueva = async (req, res) => {
    const pacientes = await Paciente.findAll();
    res.render('admisiones/nueva', { pacientes });
};

exports.guardarAdmision = async (req, res) => {
    await Admision.create(req.body);
    res.redirect('/admisiones');
};