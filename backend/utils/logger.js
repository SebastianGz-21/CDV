const winston = require('winston');
const { combine, timestamp, printf } = winston.format;
const DailyRotateFile = require('winston-daily-rotate-file');
const fs = require('fs');
const path = require('path');

// Crear carpeta logs/logger si no existe
const loggerDir = path.join(__dirname, '../logs/logger');
if (!fs.existsSync(loggerDir)) {
  fs.mkdirSync(loggerDir, { recursive: true });
}

// ✅ Función para sanitizar datos sensibles en logs
const sanitizeData = (obj) => {
  if (obj === null || obj === undefined) return obj;
  
  if (typeof obj === 'string') {
    let sanitized = obj;
    
    // Redactar contraseñas
    sanitized = sanitized.replace(/("?contraseña"?:\s*"[^"]*")/gi, '"contraseña":"***REDACTED***"');
    sanitized = sanitized.replace(/("?password"?:\s*"[^"]*")/gi, '"password":"***REDACTED***"');
    
    // Redactar tokens
    sanitized = sanitized.replace(/("?token"?:\s*"[^"]*")/gi, '"token":"***REDACTED***"');
    sanitized = sanitized.replace(/("?jwt"?:\s*"[^"]*")/gi, '"jwt":"***REDACTED***"');
    
    // Redactar emails (parcialmente)
    sanitized = sanitized.replace(/([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})/g, '[EMAIL_REDACTED]');
    
    // Redactar DNI (7-8 dígitos)
    sanitized = sanitized.replace(/\b(\d{7,8})\b/g, '[DNI_REDACTED]');
    
    return sanitized;
  }
  
  if (Array.isArray(obj)) {
    return obj.map(item => sanitizeData(item));
  }
  
  if (typeof obj === 'object') {
    const sanitized = {};
    for (const key in obj) {
      if (obj.hasOwnProperty(key)) {
        if (['contraseña', 'password', 'token', 'jwt', 'secret'].includes(key.toLowerCase())) {
          sanitized[key] = '***REDACTED***';
        } else {
          sanitized[key] = sanitizeData(obj[key]);
        }
      }
    }
    return sanitized;
  }
  
  return obj;
};

// Formato del log con sanitización
const logFormat = printf(({ level, message, timestamp }) => {
  // ✅ Sanitizar el mensaje antes de loguear
  const sanitizedMessage = sanitizeData(message);
  return `${timestamp} [${level}]: ${typeof sanitizedMessage === 'string' ? sanitizedMessage : JSON.stringify(sanitizedMessage)}`;
});

// Configuración del logger
const logger = winston.createLogger({
  level: 'info',
  format: combine(timestamp(), logFormat),
  transports: [
    new winston.transports.Console(),
    new DailyRotateFile({
      filename: path.join(loggerDir, 'auth-%DATE%.log'),
      datePattern: 'YYYY-MM-DD',
      zippedArchive: true,
      maxSize: '20m',
      maxFiles: '30d'
    }),
    new winston.transports.File({
      filename: path.join(loggerDir, 'auth-error.log'),
      level: 'error'
    })
  ]
});

// Exportar logger y función de sanitización
module.exports = logger;
module.exports.sanitizeData = sanitizeData;
