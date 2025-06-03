const express = require('express');
const router = express.Router();
const pacientesController = require('../controllers/pacientesController');

router.get('/', pacientesController.listarPacientes);
router.get('/nuevo', pacientesController.formularioNuevo);
router.post('/nuevo', pacientesController.guardarPaciente);

module.exports = router;