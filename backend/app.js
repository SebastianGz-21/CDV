const express = require('express');
const dotenv = require('dotenv');
const db = require('./db');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const path = require('path');

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json()); // Middleware para parsear JSON

// Ruta básica de prueba
app.get('/', (req, res) => {
  res.send('API funcionando');
});

// Ruta para hacer login
app.post('/login', (req, res) => {
  const { email, contrasena } = req.body;

  if (!email || !contrasena) {
    return res.status(400).json({ error: 'Faltan campos requeridos.' });
  }

  // Buscar usuario en la base de datos
  db.query('SELECT * FROM usuarios WHERE email = ?', [email], (err, results) => {
    if (err) {
      console.error('Error al buscar usuario:', err.message);
      return res.status(500).json({ error: 'Error interno del servidor' });
    }

    if (results.length === 0) {
      return res.status(404).json({ error: 'Usuario no encontrado' });
    }

    const usuario = results[0];

    // Verificar la contraseña
    bcrypt.compare(contrasena, usuario.contrasena, (err, isMatch) => {
      if (err) {
        console.error('Error al comparar contraseñas:', err.message);
        return res.status(500).json({ error: 'Error interno del servidor' });
      }

      if (!isMatch) {
        return res.status(400).json({ error: 'Contraseña incorrecta' });
      }

      // Crear un JWT para el usuario
      const token = jwt.sign(
        { id: usuario.id, nombre: usuario.nombre, rol: usuario.rol },
        process.env.JWT_SECRET || 'secreto',
        { expiresIn: '1h' } // El token expirará en 1 hora
      );

      res.json({ message: 'Inicio de sesión exitoso', token });
    });
  });
});

// Middleware para verificar el JWT (autorización)
const verificarToken = (req, res, next) => {
  const token = req.header('Authorization')?.replace('Bearer ', '');

  if (!token) {
    return res.status(401).json({ error: 'Acceso denegado. No se ha proporcionado un token.' });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET || 'secreto');
    req.user = decoded; // Guardar la información del usuario en la solicitud
    next();
  } catch (err) {
    return res.status(400).json({ error: 'Token inválido' });
  }
};

// Ruta protegida (solo usuarios con token válido)
app.get('/perfil', verificarToken, (req, res) => {
  res.json({ mensaje: `Bienvenido ${req.user.nombre}`, rol: req.user.rol });
});

const authRoutes = require('./routes/authRoutes');
app.use('/api/auth', authRoutes);

app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
