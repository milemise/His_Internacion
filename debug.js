const express = require("express");
const path = require("path");
const app = express();

// Configuración básica
app.set("view engine", "pug");
app.set("views", path.join(__dirname, "views"));

// Ruta simple de prueba
app.get("/", (req, res) => {
  console.log("✅ Servidor debug funcionando");
  res.send("¡Funciona! Prueba exitosa");
});

// Iniciar servidor
const PORT = 3001;
app.listen(PORT, () => {
  console.log(`🟢 Servidor debug en http://localhost:${PORT}`);
  console.log("🛑 Para detenerlo: Ctrl + C");
});
