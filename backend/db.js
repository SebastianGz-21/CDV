const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: process.env.DB_HOST,      // Por ejemplo: 'localhost'
  user: process.env.DB_USER,      // Por ejemplo: 'root'
  password: process.env.DB_PASS,  // Tu contraseña
  database: process.env.DB_NAME   // Nombre de la base de datos
});

// Probar conexión
connection.connect((err) => {
  if (err) {
    console.error('❌ Error al conectar a la base de datos:', err.message);
    return;
  }
  console.log('✅ Conexión a la base de datos establecida');
});

module.exports = connection;
