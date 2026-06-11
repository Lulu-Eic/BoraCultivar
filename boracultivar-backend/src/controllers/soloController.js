// src/controllers/soloController.js
import { createClient } from '@supabase/supabase-js';

// Mude para uma função que só carrega o cliente quando for chamada
const getSupabase = () => {
  return createClient(
    process.env.SUPABASE_URL,
    process.env.SUPABASE_KEY
  );
};

export async function analisarSoloController(req, res) {
  try {
    const supabase = getSupabase(); // <--- Inicializa aqui, dentro da função
    // ... resto do seu código
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Erro de configuração do servidor.' });
  }
}