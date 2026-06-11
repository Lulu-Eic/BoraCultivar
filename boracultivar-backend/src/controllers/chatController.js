
// ─────────────────────────────────────────────────────────────────
// ALTERNATIVA GRATUITA: use este arquivo se preferir o Google Gemini
// em vez da OpenAI.
//
// Para ativar:
//   1. npm install @google/generative-ai
//   2. Coloque no .env:  GEMINI_API_KEY=SUA_CHAVE
//   3. Renomeie este arquivo para chatController.js (substituindo o outro)
// ────────────────────────────────────────────────

import { GoogleGenerativeAI } from '@google/generative-ai';
 
const FLORA_SYSTEM_PROMPT = `Você é a Flora 🍃, assistente virtual do programa "Bora Cultivar?" 
da Prefeitura do Recife. Especialista em arborização urbana, espécies nativas do Nordeste 
e sustentabilidade urbana. Seja amigável, use linguagem simples, responda em português 
brasileiro, máximo 3 parágrafos por resposta.`;
 
export const chat = async (req, res, next) => {
  try {
    const { message } = req.body;
 
    if (!message || typeof message !== 'string' || message.trim() === '') {
      return res.status(400).json({ error: 'O campo "message" é obrigatório.' });
    }
 
    if (!process.env.GEMINI_API_KEY) {
      return res.status(503).json({
        error: 'A Flora ainda não está configurada. Verifique a GEMINI_API_KEY no .env',
      });
    }
 
    const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
    const model = genAI.getGenerativeModel({
      model: 'gemini-1.5-flash', // Modelo gratuito e rápido
      systemInstruction: FLORA_SYSTEM_PROMPT,
    });
 
    const result = await model.generateContent(message.trim());
    const reply = result.response.text()?.trim()
      ?? 'Desculpe, não consegui processar sua mensagem agora. Tente novamente! 🌿';
 
    return res.status(200).json({ reply });
 
  } catch (error) {
    if (error?.message?.includes('API_KEY_INVALID')) {
      return res.status(503).json({ error: 'Chave Gemini inválida. Verifique o .env' });
    }
    next(error);
  }
};