import { getAIResponse } from "../services/aiService.js";

/**
 * Controller responsável pela rota POST /chat.
 *
 * Responsabilidades:
 *  - Validar os dados da requisição (camada HTTP).
 *  - Chamar o serviço de IA.
 *  - Formatar e devolver a resposta ao frontend.
 */
export async function handleChat(req, res) {
  try {
    const { message } = req.body;

    // Validação básica da entrada
    if (!message || typeof message !== "string" || message.trim() === "") {
      return res.status(400).json({
        error: 'O campo "message" é obrigatório e deve ser uma string não vazia.',
      });
    }

    // Delega a lógica da IA ao serviço isolado
    const reply = await getAIResponse(message.trim());

    return res.status(200).json({ reply });
  } catch (error) {
    console.error("[chatController] Erro ao processar mensagem:", error);
    return res.status(500).json({
      error: "Ocorreu um erro interno. Tente novamente mais tarde.",
    });
  }
}
