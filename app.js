const express = require('express');
const path = require('path');
const app = express();

// Importar rutas
const pacientesRoutes = require('./routes/pacientes');
const admisionesRoutes = require('./routes/admisiones');

// Configurar el motor de vistas
app.set('view engine', 'pug');
app.set('views', path.join(__dirname, 'views'));

// Middleware para parsear formularios
app.use(express.urlencoded({ extended: true }));

// Servir archivos estáticos (css, js, imágenes)
app.use(express.static(path.join(__dirname, 'public')));

// Rutas
app.use('/pacientes', pacientesRoutes);
app.use('/admisiones', admisionesRoutes);

// Ruta base - redirige a pacientes
app.get('/', (req, res) => {
  res.redirect('/pacientes');
});

// Importar conexión Sequelize
const sequelize = require('./models/sequelize');

// Sincronizar la base de datos y luego levantar servidor
sequelize.sync({ alter: true })
  .then(() => {
    console.log('🟢 Base de datos sincronizada');
    app.listen(3000, () => {
      console.log('🟢 Servidor en http://localhost:3000');
    });
  })
  .catch(err => {
    console.error('🔴 Error al sincronizar:', err);
  });
