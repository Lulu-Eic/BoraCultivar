// src/controllers/authController.js
import pool from '../models/db.js';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';

const SALT_ROUNDS = 10;

export const registrar = async (req, res, next) => {
  try {
    const { id, nome, email, novasenha } = req.body;

    if (!nome || !email || !senha) {
      return res.status(400).json({ error: 'Nome, e-mail e senha são obrigatórios.' });
    }

    const [usuarioExistente] = await pool.query('SELECT id FROM usuario WHERE email = ?', [email]);
    if (usuarioExistente.length > 0) {
      return res.status(409).json({ error: 'E-mail já cadastrado.' });
    }

    const senhaHash = await bcrypt.hash(senha, SALT_ROUNDS);
    // Usando campos mapeados corretamente
    await pool.query(
      'INSERT INTO usuario (id, nome, email, senha_hash) VALUES (UUID(), ?, ?, ?)',
      [nome, email, senhaHash]
    );

    res.status(201).json({ message: 'Usuário registrado com sucesso.' });
  } catch (error) {
    next(error);
  }
};

export const login = async (req, res, next) => {
  try {
    const { email, senha } = req.body;

    if (!email || !senha) return res.status(400).json({ error: 'Campos obrigatórios faltando.' });

    const [usuarios] = await pool.query('SELECT * FROM usuario WHERE email = ?', [email]);
    if (usuarios.length === 0) return res.status(401).json({ error: 'Credenciais inválidas.' });

    const usuario = usuarios[0];
    const senhaValida = await bcrypt.compare(senha, usuario.senha_hash);
    if (!senhaValida) return res.status(401).json({ error: 'Credenciais inválidas.' });

    const token = jwt.sign({ id: usuario.id }, process.env.JWT_SECRET || 'secreto', { expiresIn: '24h' });

    res.status(200).json({
      token,
      usuario: { id: usuario.id, nome: usuario.nome, email: usuario.email }
    });
  } catch (error) {
    next(error);
  }
};
export const atualizarPerfil = async (req, res, next) => {
  try {
    const { id, nome, email, novaSenha } = req.body;

    if (!id || !nome || !email) {
      return res.status(400).json({
        error: 'ID, nome e email são obrigatórios.'
      });
    }

    const [usuarios] = await pool.query(
      'SELECT * FROM usuario WHERE id = ?',
      [id]
    );

    if (usuarios.length === 0) {
      return res.status(404).json({
        error: 'Usuário não encontrado.'
      });
    }

    if (novaSenha && novaSenha.trim() !== '') {
      const senhaHash = await bcrypt.hash(
        novaSenha,
        SALT_ROUNDS
      );

      await pool.query(
        `
        UPDATE usuario
        SET nome = ?, email = ?, senha_hash = ?
        WHERE id = ?
        `,
        [nome, email, senhaHash, id]
      );
    } else {
      await pool.query(
        `
        UPDATE usuario
        SET nome = ?, email = ?
        WHERE id = ?
        `,
        [nome, email, id]
      );
    }

    const [atualizado] = await pool.query(
      `
      SELECT id, nome, email
      FROM usuario
      WHERE id = ?
      `,
      [id]
    );

    return res.status(200).json(atualizado[0]);
  } catch (error) {
    next(error);
  }
};