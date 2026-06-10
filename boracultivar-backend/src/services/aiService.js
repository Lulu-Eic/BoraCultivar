/**
 * aiService.js
 * ─────────────────────────────────────────────────────────────────────────────
 * Serviço responsável por toda a lógica de inteligência artificial.
 *
 * ATENÇÃO PARA QUEM FOR INTEGRAR A IA REAL:
 *  1. Substitua o corpo da função `getAIResponse` pela chamada à IA desejada
 *     (ex: OpenAI, Gemini, modelo local, etc.).
 *  2. Mantenha a assinatura da função:
 *       - Entrada : message (string)
 *       - Saída   : Promise<string>  ← texto da resposta
 *  3. Não é necessário alterar nenhum outro arquivo do projeto.
 * ─────────────────────────────────────────────────────────────────────────────
 */

/**
 * Retorna uma resposta para a mensagem do usuário.
 *
 * @param {string} message - Mensagem enviada pelo usuário via frontend.
 * @returns {Promise<string>} - Resposta textual da IA (ou simulada).
 */
export async function getAIResponse(message) {
  // ── RESPOSTA SIMULADA ──────────────────────────────────────────────────────
  // Esta implementação é temporária e serve apenas para desenvolvimento/testes.
  // Substitua TODO o bloco abaixo pela integração com a IA real.
  // ──────────────────────────────────────────────────────────────────────────

  // Simula um pequeno delay de rede/processamento (remova ao integrar a IA real)
  await new Promise((resolve) => setTimeout(resolve, 500));

  const respostasSimuladas = [
    `Ótima pergunta sobre "${message}"! 🌱 Em breve nossa IA especializada em cultivo estará disponível para te ajudar com isso.`,
    `Recebi sua mensagem: "${message}". A inteligência artificial do Bora Cultivar está em desenvolvimento e logo te dará dicas personalizadas de plantio!`,
    `Que bom que você perguntou sobre "${message}"! Nossa equipe está preparando uma IA incrível para responder isso com precisão. Aguarde!`,
  ];

  const indiceAleatorio = Math.floor(Math.random() * respostasSimuladas.length);
  return respostasSimuladas[indiceAleatorio];

  // ── EXEMPLO DE INTEGRAÇÃO COM OPENAI (descomente e adapte quando necessário) ─
  //
  // import OpenAI from "openai";
  // const client = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });
  //
  // const completion = await client.chat.completions.create({
  //   model: "gpt-4o",
  //   messages: [
  //     { role: "system", content: "Você é um especialista em cultivo de plantas e horticultura urbana." },
  //     { role: "user",   content: message },
  //   ],
  // });
  //
  // return completion.choices[0].message.content;
  // ─────────────────────────────────────────────────────────────────────────────
}
