const { Ala, Habitacion, Cama, Admision, Paciente, AsignacionCama } = require('../models');

exports.mostrarMapa = async (req, res) => {
    try {
        const alas = await Ala.findAll({
            include: [{
                model: Habitacion,
                include: [{
                    model: Cama,
                    include: [{
                        model: Admision,
                        through: {
                            model: AsignacionCama,
                            where: { es_actual: true }
                        },
                        required: false,
                        include: [{
                            model: Paciente,
                            attributes: ['id_paciente', 'nombre', 'apellido', 'dni']
                        }]
                    }]
                }]
            }],
            order: [
                ['nombre', 'ASC'],
                [Habitacion, 'numero', 'ASC'],
                [Habitacion, Cama, 'numero', 'ASC']
            ]
        });
        res.render('habitaciones/mapa', { alas });
    } catch (error) {
        res.status(500).send(error.message);
    }
};