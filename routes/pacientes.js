const express = require('express');
const router = express.Router();
const pacientesController = require('../controllers/pacientesController');
console.log(pacientesController);
router.get('/', pacientesController.listarPacientes);
router.get('/nuevo', pacientesController.formularioNuevo);
router.post('/nuevo', pacientesController.guardarPaciente);
router.get('/:id/editar', pacientesController.mostrarFormularioEditar);
router.post('/:id/editar', pacientesController.editarPaciente);

module.exports = router;