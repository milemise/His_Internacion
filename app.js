const express = require('express');
const app = express();
const path = require('path');
const pacientesRoutes = require('./routes/pacientes');
const admisionesRoutes = require('./routes/admisiones');

app.set('view engine', 'pug');
app.set('views', path.join(__dirname, 'views'));

app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));

app.use('/pacientes', pacientesRoutes);
app.use('/admisiones', admisionesRoutes);

app.get('/', (req, res) => {
    res.redirect('/pacientes');
});

app.listen(3000, () => console.log('Servidor funcionando en http://localhost:3000'));