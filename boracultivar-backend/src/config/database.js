// src/config/database.js
import mysql from 'mysql2/promise';

const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',             
  password: 'th61L2Oa@T', // ⚠️ Garanta que esta é a sua senha local
  database: 'bora_cultivar',       // ✅ Atualizado com o nome correto do seu banco!
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Autoteste de conexão
(async () => {
  try {
    const connection = await pool.getConnection();
    console.log('🗄️  Conexão com o banco MySQL estabelecida com sucesso!');
    connection.release();
  } catch (error) {
    console.error('❌ Erro crítico ao conectar no MySQL:', error.message);
  }
})();

export default pool;