const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const db = require('./db'); // Asegurate de crear este archivo después

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middlewares
app.use(cors()); // Habilita CORS
app.use(express.json()); // Permite recibir JSON

// Ruta de prueba
app.get('/', (req, res) => {
  res.send('API CDV funcionando');
});

// Escucha
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
