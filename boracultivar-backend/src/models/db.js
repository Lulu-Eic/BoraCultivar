// src/models/db.js
import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

dotenv.config();

// Cria o pool de conexões utilizando as variáveis de ambiente
const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Teste inicial de conexão para exibir feedback limpo no terminal
try {
  const connection = await pool.getConnection();
  console.log('🗄️  Conexão com o banco MySQL estabelecida com sucesso!');
  connection.release(); // Devolve a conexão para o pool
} catch (error) {
  console.error('❌ Erro crítico ao conectar no banco de dados:', error.message);
}

export default pool;