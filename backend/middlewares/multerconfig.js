const multer = require('multer');
const path = require('path');

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, path.join(__dirname, '../uploads/documentos_titular'));
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, `${uniqueSuffix}-${file.originalname}`);
  }
});

// ✅ Validación mejorada: MIME type + extensión
const fileFilter = (req, file, cb) => {
  // MIME types permitidos
  const allowedMimeTypes = ['image/jpeg', 'image/png', 'application/pdf'];
  
  // Extensiones permitidas
  const allowedExtensions = ['.jpg', '.jpeg', '.png', '.pdf'];
  const fileExtension = path.extname(file.originalname).toLowerCase();

  // Validar MIME type
  if (!allowedMimeTypes.includes(file.mimetype)) {
    return cb(new Error('Tipo de archivo no permitido. Solo JPEG, PNG o PDF.'), false);
  }

  // Validar extensión
  if (!allowedExtensions.includes(fileExtension)) {
    return cb(new Error('Extensión de archivo no permitida.'), false);
  }

  cb(null, true);
};

// ✅ Límites mejorados
const upload = multer({ 
  storage,
  fileFilter,
  limits: { 
    fileSize: 10 * 1024 * 1024, // Límite de 10MB
    files: 10 // Máximo 10 archivos por request
  }
});

module.exports = upload;