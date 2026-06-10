// lib/screens/about_screen.dart
import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/routes/app_routes.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quem Somos'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppTheme.primaryGreen, // Ajustado para o tema
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nossa Missão',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryGreen),
            ),
            const SizedBox(height: 8),
            const Text(
              'Esta página traz detalhes abrangentes sobre nossa missão. Estamos trabalhando intensamente para tornar Recife uma cidade muito mais verde, sustentável e preparada para mitigar as ilhas de calor urbanas.',
              style: TextStyle(fontSize: 15, height: 1.4),
            ),
            const SizedBox(height: 24),

            const Text(
              'Por que a Capivara?',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryGreen),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppTheme.accentGreen.withValues(
                        alpha: 0.15), // Integração suave com a cor de destaque
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.pets,
                      color: AppTheme.primaryGreen, size: 36),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'A capivara é um símbolo massivo e importante da fauna recifense, habitando as margens e mangues dos rios como o Capibaribe. Daí a origem de nosso programa de gamificação "Capiba Verde". Ela representa a coexistence pacífica da natureza com o ecossistema urbano construído.',
                    style: TextStyle(fontSize: 14),
                  ),
                )
              ],
            ),
            const SizedBox(height: 32),

            // CARD CONTRIBUA
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 8),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contribua com o Raiz Urbana',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppTheme.primaryGreen),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Você pode ajudar na transformação ambiental financiando insumos de adubo e mudas nativas, além de acumular moedas virtuais do programa Capiba Verde.',
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // backgroundColor e formato arredondado agora são injetados pelo AppTheme
                      minimumSize: const Size(double.infinity,
                          45), // Deixa o botão expandido e confortável para o toque
                    ),
                    onPressed: () =>
                        Navigator.of(context).pushNamed(AppRoutes.requestPlanting),
                    child: const Text('Solicitar Plantio de Apoio'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
