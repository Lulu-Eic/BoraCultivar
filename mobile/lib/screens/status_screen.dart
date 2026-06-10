// lib/screens/status_screen.dart
import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status da Solicitação'), 
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        foregroundColor: AppTheme.primaryGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Digite o número do protocolo recebido por e-mail para verificar o andamento real do plantio.', 
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),
            
            // CAMPO DE BUSCA REESTRUTURADO
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number, // Otimiza o teclado para números de protocolo
                    decoration: const InputDecoration(
                      hintText: 'Ex: 123456',
                      // O inputDecorationTheme global do AppTheme gerencia as bordas automaticamente
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Transformado em um botão clicável com feedback visual (InkWell)
                InkWell(
                  onTap: () {
                    // Futura lógica de consulta à API/Banco de dados
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 56, 
                    width: 56,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen, 
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(height: 32),
            
            // CONTAINER COM OS PRAZOS REESTILIZADO
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withValues(alpha: 0.06), // Fundo suave usando a cor identidade
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Prazos estimados para cada etapa:', 
                    style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryGreen, fontSize: 15),
                  ),
                  const SizedBox(height: 18),
                  _buildStatusLine(Colors.grey, 'Recebido:', 'Sua solicitação foi registrada (imediato)'),
                  _buildStatusLine(Colors.amber, 'Análise Técnica:', 'Avaliação de viabilidade física local (até 15 dias)'),
                  _buildStatusLine(Colors.blue, 'Agendado:', 'Plantio programado em mutirão urbano (15-30 dias após aprovação)'),
                  _buildStatusLine(AppTheme.accentGreen, 'Concluído:', 'Árvore plantada com sucesso e georreferenciada!'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatusLine(Color color, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3.0), // Centraliza sutilmente o marcador com a primeira linha
            child: Icon(Icons.circle, color: color, size: 12),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87, fontSize: 14, height: 1.3), 
                children: [
                  TextSpan(text: '$title ', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: desc),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}