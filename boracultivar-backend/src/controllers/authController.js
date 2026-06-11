// src/controllers/authController.js
import { createClient } from "@supabase/supabase-js";

// Inicializa o cliente do Supabase
const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_KEY,
);

/**
 * NOTA: O Login e o Registro agora são feitos via Flutter SDK.
 * Mantenha estas funções apenas se precisar de uma lógica específica
 * de servidor (ex: gatilhos de boas-vindas).
 */

export const atualizarPerfil = async (req, res, next) => {
  try {
    const { id, nome, email } = req.body;

    if (!id || !nome || !email) {
      return res
        .status(400)
        .json({ error: "ID, nome e email são obrigatórios." });
    }

    // Usamos o Supabase para atualizar a tabela 'usuario' (ou 'profiles')
    const { data, error } = await supabase
      .from("usuario")
      .update({ nome, email })
      .eq("id", id)
      .select();

    if (error) throw error;

    return res.status(200).json(data[0]);
  } catch (error) {
    console.error("Erro ao atualizar perfil no Supabase:", error);
    next(error);
  }
};
