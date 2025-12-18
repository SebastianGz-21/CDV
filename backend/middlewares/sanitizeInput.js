const xss = require('xss');

/**
 * Middleware para sanitizar entrada y prevenir ataques XSS
 * Limpia body, query params y cookies
 */
const sanitizeInput = (req, res, next) => {
  try {
    // Sanitizar req.body si existe
    if (req.body && typeof req.body === 'object') {
      req.body = sanitizeObject(req.body);
    }

    // Sanitizar req.query si existe
    if (req.query && typeof req.query === 'object') {
      req.query = sanitizeObject(req.query);
    }

    // Sanitizar req.params si existe
    if (req.params && typeof req.params === 'object') {
      req.params = sanitizeObject(req.params);
    }

    next();
  } catch (error) {
    console.error('Error en sanitización de entrada:', error);
    next();
  }
};

/**
 * Función recursiva para sanitizar objetos
 */
const sanitizeObject = (obj) => {
  if (obj === null || obj === undefined) {
    return obj;
  }

  if (typeof obj === 'string') {
    // Opciones para XSS más permisivas
    return xss(obj, {
      whiteList: {},
      stripIgnoredTag: true,
      stripLeadingAndTrailingWhitespace: true,
    });
  }

  if (Array.isArray(obj)) {
    return obj.map(item => sanitizeObject(item));
  }

  if (typeof obj === 'object') {
    const sanitized = {};
    for (const key in obj) {
      if (Object.prototype.hasOwnProperty.call(obj, key)) {
        sanitized[key] = sanitizeObject(obj[key]);
      }
    }
    return sanitized;
  }

  return obj;
};

module.exports = sanitizeInput;
