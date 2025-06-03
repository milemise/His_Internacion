const express = require('express');
const router = express.Router();
const admisionesController = require('../controllers/admisionesController');

router.get('/', admisionesController.listarAdmisiones);
router.get('/nueva', admisionesController.formularioNueva);
router.post('/nueva', admisionesController.guardarAdmision);

module.exports = router;