const { Turno, Paciente, Medico } = require('../models');

exports.listar = async (req, res) => {
    try {
        const turnos = await Turno.findAll({
            include: [
                { model: Paciente, attributes: ['nombre', 'apellido'] },
                { model: Medico, attributes: ['nombre', 'apellido'] }
            ],
            order: [['fecha_hora', 'ASC']]
        });
        res.render('turnos/index', { turnos });
    } catch (error) {
        res.status(500).send(error.message);
    }
};

exports.mostrarFormularioNuevo = async (req, res) => {
    try {
        const pacientes = await Paciente.findAll({ order: [['apellido', 'ASC']] });
        const medicos = await Medico.findAll({ order: [['apellido', 'ASC']] });
        res.render('turnos/nuevo', { pacientes, medicos });
    } catch (error) {
        res.status(500).send(error.message);
    }
};

exports.crear = async (req, res) => {
    try {
        await Turno.create(req.body);
        res.redirect('/turnos');
    } catch (error) {
        res.status(500).send(error.message);
    }
};

exports.mostrarFormularioEditar = async (req, res) => {
    try {
        const turno = await Turno.findByPk(req.params.id);
        const pacientes = await Paciente.findAll({ order: [['apellido', 'ASC']] });
        const medicos = await Medico.findAll({ order: [['apellido', 'ASC']] });
        if (turno) {
            res.render('turnos/editar', { turno, pacientes, medicos });
        } else {
            res.status(404).send('Turno no encontrado');
        }
    } catch (error) {
        res.status(500).send(error.message);
    }
};

exports.actualizar = async (req, res) => {
    try {
        await Turno.update(req.body, {
            where: { id_turno: req.params.id }
        });
        res.redirect('/turnos');
    } catch (error) {
        res.status(500).send(error.message);
    }
};

exports.eliminar = async (req, res) => {
    try {
        await Turno.destroy({
            where: { id_turno: req.params.id }
        });
        res.redirect('/turnos');
    } catch (error) {
        res.status(500).send(error.message);
    }
};