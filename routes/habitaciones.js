const express = require('express');
const router = express.Router();
const habitacionesController = require('../controllers/habitacionesController');

router.get('/mapa', habitacionesController.mostrarMapa);

module.exports = router;