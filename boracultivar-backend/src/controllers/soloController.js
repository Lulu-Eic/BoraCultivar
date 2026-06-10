// src/controllers/soloController.js
import { classificarSolo } from '../services/analiseSoloService.js';
import pool from '../config/database.js'; 

export async function analisarSoloController(req, res) {
  try {
    // 1. Validação de segurança inicial
    if (!req.file) {
      return res.status(400).json({ error: 'Nenhum arquivo de imagem foi enviado.' });
    }

    const caminhoImagem = req.file.path;

    // 2. Tenta processar com a IA (o serviço mockado atual)
    let resultadoIA;
    try {
      resultadoIA = await classificarSolo(caminhoImagem);
    } catch (iaError) {
      console.error('Erro na IA:', iaError);
      return res.status(502).json({ error: 'O motor de análise está indisponível no momento.' });
    }

    // 3. Tenta salvar no Banco de Dados
    try {
      const query = `
        INSERT INTO analises_solo (caminho_imagem, classe_resultado, confianca, laudo) 
        VALUES (?, ?, ?, ?)
      `;
      
      await pool.query(query, [
        caminhoImagem, 
        resultadoIA.classe, 
        resultadoIA.confianca, 
        resultadoIA.laudo
      ]);
      console.log('💾 Análise persistida com sucesso no MySQL!');
    } catch (dbError) {
      console.error('Erro ao salvar no banco:', dbError);
      // Se a IA funcionou mas o banco falhou, retornamos o laudo da IA 
      // mas avisamos que o histórico não foi salvo
      return res.status(201).json({ 
        ...resultadoIA, 
        aviso: 'Análise gerada, mas falha ao salvar histórico no banco.' 
      });
    }

    // 4. Sucesso total
    return res.status(200).json(resultadoIA);

  } catch (error) {
    console.error('Erro crítico no controlador:', error);
    return res.status(500).json({ error: 'Erro inesperado no servidor.' });
  }
}