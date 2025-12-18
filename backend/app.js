const express = require('express');
const dotenv = require('dotenv');
const cors = require('cors');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');
const path = require('path');
const db = require('./db');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const verificarToken = require('./middlewares/verificarToken');
const detectarInyeccionSQL = require('./middlewares/detectarInySQL');
const sanitizeInput = require('./middlewares/sanitizeInput');
const { servirArchivosSeguro, validarRutaSegura } = require('./middlewares/servirArchivosSeguro');

dotenv.config();

const app = express();

// ✅ Helmet para headers HTTP seguros
app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      styleSrc: ["'self'", "'unsafe-inline'", 'https://cdn.jsdelivr.net', 'https://cdnjs.cloudflare.com'],
      scriptSrc: ["'self'", 'https://cdn.jsdelivr.net', 'https://cdnjs.cloudflare.com'],
      imgSrc: ["'self'", 'data:', 'https:', 'https://cdn.jsdelivr.net', 'https://cdnjs.cloudflare.com'],
      fontSrc: ["'self'", 'https://cdnjs.cloudflare.com', 'data:'],
      connectSrc: ["'self'"],
    },
  },
  hsts: {
    maxAge: 31536000, // 1 año
    includeSubDomains: true,
    preload: true,
  },
  frameguard: {
    action: 'deny',
  },
  referrerPolicy: {
    policy: 'strict-origin-when-cross-origin',
  },
}));

// ✅ CORS restrictivo - solo dominio autorizado
const corsOptions = {
  origin: process.env.CORS_ORIGIN || 'http://localhost:3000',
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization'],
  maxAge: 86400,
};
app.use(cors(corsOptions)); 

const PORT = process.env.PORT || 3000;

// Middleware para parsear JSON
app.use(express.json({ limit: '50mb' }));
// Middleware para parsear URL-encoded
app.use(express.urlencoded({ extended: true, limit: '50mb' }));

// ✅ Sanitización de entrada (prevenir XSS)
app.use(sanitizeInput);

// Middleware para servir archivos estáticos (frontend)
app.use(express.static(path.join(__dirname, '../frontend')));

// ✅ Servir QR SIN autenticación (son públicos)
app.use('/uploads/qr', express.static(path.join(__dirname, 'uploads/qr')));

// ✅ Servir documentos de titulares SIN autenticación (información pública del comercio)
app.use('/uploads/documentos_titular', express.static(path.join(__dirname, 'uploads/documentos_titular')));

// ✅ Servir fotos de procedimientos SIN autenticación (información pública del comercio)
app.use('/uploads/procedimientos', express.static(path.join(__dirname, 'uploads/procedimientos')));

// ✅ Servir documentos de comercios SIN autenticación (información pública del comercio)
app.use('/uploads/documentos_comercio', express.static(path.join(__dirname, 'uploads/documentos_comercio')));

// ✅ Servir documentos de transportes SIN autenticación (información pública del comercio)
app.use('/uploads/documentos_transporte', express.static(path.join(__dirname, 'uploads/documentos_transporte')));

// ✅ Servir archivos subidos con autenticación y validación segura (EXCEPTO las rutas públicas anteriores)
app.use('/uploads', servirArchivosSeguro, validarRutaSegura, express.static(path.join(__dirname, 'uploads')));

// Evitar 401 en favicon para todas las páginas (sin afectar autenticación)
app.get('/favicon.ico', (req, res) => res.status(204).end());

app.use(detectarInyeccionSQL);

app.get('/test', (req, res) => {
  res.send('Ruta accesible');
});

// Ruta básica de prueba
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, '../frontend/pages/login.html'));
});

// Importar y usar rutas de autenticación
const authRoutes = require('./routes/authRoutes');
app.use('/api/auth', authRoutes);

// Alta comercio
const altaComercioRoutes = require('./routes/altaComercioRoutes');
app.use('/api/alta-comercio', altaComercioRoutes);

// Alta transporte
const altaTransporteRoutes = require('./routes/altaTransporteRoutes');
app.use('/api/alta-transporte', altaTransporteRoutes);

// Renovación transporte
const renovacionTransporteRoutes = require('./routes/renovacionTransporteRoutes');
app.use('/api/renovacion-transporte', renovacionTransporteRoutes);

// Renovación comercio
const renovacionComercioRoutes = require('./routes/renovacionComercioRoutes');
app.use('/api/renovacion-comercio', renovacionComercioRoutes);

// Registro comercio
const comercioRoutes = require('./routes/comercioRoutes');
app.use('/', comercioRoutes);
app.use('/api/comercios', comercioRoutes);

// Registro transporte (réplica adaptada de comercio)
const transporteRoutes = require('./routes/transporteRoutes');
app.use('/', transporteRoutes);
app.use('/api/transportes', transporteRoutes);

// procedimiento
const procedimientoRoutes = require('./routes/procedimientoRoutes');
app.use('/api/procedimientos', procedimientoRoutes);

// registro titular
const titularRoutes = require('./routes/titularRoutes');
app.use('/api/titular', titularRoutes);


// nueva ruta para listar titulares unificados (razon_social + titular_ambulante)
const titularesRoutes = require('./routes/titularesRoutes');
app.use('/api/titulares-unificados', titularesRoutes);


// Levantar servidor
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});


