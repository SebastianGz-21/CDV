const multer = require('multer');
const path = require('path');

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, path.join(__dirname, '../uploads/fotos_perfil'));
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    const extension = path.extname(file.originalname);
    cb(null, `perfil-${uniqueSuffix}${extension}`);
  }
});

// Validación: solo imágenes JPEG, PNG
const fileFilter = (req, file, cb) => {
  const allowedMimeTypes = ['image/jpeg', 'image/png', 'image/jpg'];
  const allowedExtensions = ['.jpg', '.jpeg', '.png'];
  const fileExtension = path.extname(file.originalname).toLowerCase();

  if (!allowedMimeTypes.includes(file.mimetype)) {
    return cb(new Error('Solo se permiten imágenes JPG o PNG'), false);
  }

  if (!allowedExtensions.includes(fileExtension)) {
    return cb(new Error('Extensión de archivo no permitida'), false);
  }

  cb(null, true);
};

const uploadFotoPerfil = multer({ 
  storage,
  fileFilter,
  limits: { 
    fileSize: 5 * 1024 * 1024, // Límite de 5MB para fotos de perfil
    files: 1 // Solo 1 archivo
  }
});

module.exports = uploadFotoPerfil;
