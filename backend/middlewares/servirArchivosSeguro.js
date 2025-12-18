const path = require('path');
const jwt = require('jsonwebtoken');

/**
 * Middleware para servir archivos de manera segura
 * - Requiere autenticación (token JWT válido)
 * - Previene path traversal attacks
 * - Valida que la ruta solicitada sea segura
 */
const servirArchivosSeguro = (req, res, next) => {
  try {
    // Extraer token del header Authorization
    const token = req.headers.authorization?.split(' ')[1];

    if (!token) {
      return res.status(401).json({ error: 'Token no proporcionado' });
    }

    // Verificar que el token sea válido
    jwt.verify(token, process.env.JWT_SECRET || 'secreto123', (err, decoded) => {
      if (err) {
        return res.status(403).json({ error: 'Token inválido o expirado' });
      }

      // Token válido, continuar al siguiente middleware
      req.usuario = decoded;
      next();
    });
  } catch (error) {
    console.error('Error en servirArchivosSeguro:', error);
    return res.status(500).json({ error: 'Error al verificar seguridad' });
  }
};

/**
 * Middleware adicional para prevenir path traversal
 */
const validarRutaSegura = (req, res, next) => {
  try {
    // Obtener la ruta solicitada
    const rutaSolicitada = req.path;

    // Detectar intentos de path traversal
    if (rutaSolicitada.includes('..') || rutaSolicitada.includes('~')) {
      return res.status(403).json({ error: 'Acceso denegado' });
    }

    // Resolver la ruta absoluta y verificar que está dentro de /uploads
    const uploadsDir = path.join(__dirname, '../uploads');
    const rutaAbsoluta = path.resolve(uploadsDir, rutaSolicitada.substring(1)); // Remover primer /

    if (!rutaAbsoluta.startsWith(uploadsDir)) {
      return res.status(403).json({ error: 'Acceso denegado' });
    }

    next();
  } catch (error) {
    console.error('Error validando ruta:', error);
    return res.status(403).json({ error: 'Acceso denegado' });
  }
};

module.exports = { servirArchivosSeguro, validarRutaSegura };
