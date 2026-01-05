-- Agregar campo foto_perfil a la tabla empleado
-- Ejecutar este script en la base de datos si aún no se ha agregado el campo

ALTER TABLE empleado 
ADD COLUMN foto_perfil VARCHAR(255) NULL 
COMMENT 'Ruta de la foto de perfil del empleado';

-- Verificar que el campo se agregó correctamente
DESCRIBE empleado;
