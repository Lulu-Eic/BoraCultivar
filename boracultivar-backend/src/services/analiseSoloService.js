// src/services/analiseSoloService.js

/**
 * SERVIÇO MOCKADO TEMPORARIAMENTE
 * Este código simula a resposta da Inteligência Artificial do Bora Cultivar.
 * Ele permite que o restante do backend seja desenvolvido e testado sem travar o projeto com erros de pacotes.
 */
export async function classificarSolo(caminhoImagem) {
  try {
    if (!caminhoImagem) {
      throw new Error('Caminho do arquivo de imagem inválido ou ausente.');
    }

    console.log(`📸 [Mock IA] Imagem recebida para análise: ${caminhoImagem}`);
    console.log('🤖 Simulando resposta do modelo Teachable Machine...');

    // Simulamos um pequeno delay de processamento para parecer real (500ms)
    await new Promise((resolve) => setTimeout(resolve, 500));

    // Array com as duas classes do seu projeto
    const classes = ["Lugar adequado para Plantio", "Lugar não adequado para Plantio"];
    
    // Sorteia ou define uma resposta padrão de sucesso para os seus testes
    // Para testar o cenário "Não adequado", você pode mudar o índice para 1
    const maiorIndice = 0; 
    
    const classeIdentificada = classes[maiorIndice];
    const scoreConfianca = (85 + Math.random() * 14).toFixed(2); // Gera uma confiança realista entre 85% e 99%

    const laudoTextual = maiorIndice === 0
      ? "Parabéns! O solo apresenta ótimas condições visuais e de textura para o plantio no ecossistema Bora Cultivar."
      : "Atenção: O local ou solo analisado não apresenta as características ideais de fertilidade visual. Sugerimos tratamento prévio da terra.";

    return {
      classe: classeIdentificada,
      confianca: `${scoreConfianca}%`,
      laudo: laudoTextual
    };

  } catch (error) {
    console.error('Erro no serviço mockado:', error);
    throw new Error('Falha simulada no motor de Inteligência Artificial.');
  }
}