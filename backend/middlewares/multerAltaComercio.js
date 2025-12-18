const multer = require('multer');
const path = require('path');

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, path.join(__dirname, '../uploads/documentos_comercio'));
    },
    filename: (req, file, cb) => {
        const uniqueSuffix = `${Date.now()}-${Math.round(Math.random() * 1E9)}`;
        const ext = path.extname(file.originalname);
        cb(null, `${file.fieldname}-${uniqueSuffix}${ext}`);
    }
});

// ✅ Validación mejorada: MIME type + extensión
const fileFilter = (req, file, cb) => {
    // MIME types permitidos
    const allowedMimeTypes = [
        'image/jpeg', 
        'image/png', 
        'application/pdf',
        'application/msword',
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
    ];
    
    // Extensiones permitidas
    const allowedExtensions = ['.jpg', '.jpeg', '.png', '.pdf', '.doc', '.docx'];
    const fileExtension = path.extname(file.originalname).toLowerCase();
    
    // Validar MIME type
    if (!allowedMimeTypes.includes(file.mimetype)) {
        return cb(new Error('Tipo de archivo no permitido'), false);
    }
    
    // Validar extensión
    if (!allowedExtensions.includes(fileExtension)) {
        return cb(new Error('Extensión de archivo no permitida'), false);
    }
    
    cb(null, true);
};

// ✅ Límites mejorados
module.exports = multer({
    storage,
    fileFilter,
    limits: { 
        fileSize: 30 * 1024 * 1024,  // 30MB por archivo
        files: 15  // Máximo 15 archivos por request
    }
});