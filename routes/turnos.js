const express = require('express');
const router = express.Router();
const turnosController = require('../controllers/turnosController');

router.get('/', turnosController.listar);
router.get('/nuevo', turnosController.mostrarFormularioNuevo);
router.post('/nuevo', turnosController.crear);
router.get('/editar/:id', turnosController.mostrarFormularioEditar);
router.post('/editar/:id', turnosController.actualizar);
router.post('/eliminar/:id', turnosController.eliminar);

module.exports = router;