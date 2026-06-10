// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../widgets/flora_floating_button.dart';
import '../core/routes/app_routes.dart';
import '../core/theme/app_theme.dart'; // Importando o tema centralizado

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // HEADER CUSTOMIZADO
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: AppTheme.primaryGreen, // Puxando do AppTheme
                      radius: 18,
                      child: Icon(Icons.eco, color: AppTheme.accentGreen, size: 20),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Bora\ncultivar?',
                      style: TextStyle(
                        color: AppTheme.primaryGreen, 
                        fontWeight: FontWeight.bold, 
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.account_circle, color: AppTheme.primaryGreen, size: 28),
                      onPressed: () => Navigator.pushNamed(context, AppRoutes.auth),
                    ),
                    const SizedBox(width: 4),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryGreen,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () => Navigator.pushNamed(context, AppRoutes.auth),
                      child: const Text('Entrar', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),

              // HERO GREEN BANNER
              Container(
                color: AppTheme.primaryGreen, // Puxando do AppTheme
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Uma cidade mais\nverde começa\ncom você.',
                      style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, height: 1.2),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Transforme sua calçada em um space de vida. Solicite o plantio gratuito de árvores e ajude a refrescar o Recife.',
                      style: TextStyle(color: Colors.grey[300], fontSize: 15),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppTheme.primaryGreen,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      ),
                      icon: const Icon(Icons.spa),
                      label: const Text('Quero plantar uma árvore', style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () => Navigator.pushNamed(context, AppRoutes.requestPlanting),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white38),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      ),
                      icon: const Icon(Icons.assignment),
                      label: const Text('Acompanhar Solicitação'),
                      onPressed: () => Navigator.pushNamed(context, AppRoutes.status),
                    ),
                  ],
                ),
              ),

              // COMO FUNCIONA
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Text(
                      'Como funciona?', 
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen),
                    ),
                    const SizedBox(height: 20),
                    _buildStepCard('1', 'Solicite', 'Preencha o formulário com seus dados e o endereço.'),
                    _buildStepCard('2', 'Aguarde', 'Nossa equipe técnica avaliará a viabilidade do local.'),
                    _buildStepCard('3', 'Dia do plantio!', 'Cuide da sua árvore e compartilhe fotos com a gente.'),
                  ],
                ),
              ),

              // ATENÇÃO ONDE NÃO PLANTAR & QUEM SOMOS LINK
              Container(
                color: Colors.amber[50],
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.warning, color: Colors.amber),
                        SizedBox(width: 8),
                        Text('Atenção onde não plantar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Evite plantar sob fiação elétrica externa ativa, canos subterrâneos mapeados ou locais que obstruam a acessibilidade urbana.'),
                    TextButton(
                      // AJUSTADO: Agora usando a classe centralizada de rotas de forma segura
                      onPressed: () => Navigator.pushNamed(context, AppRoutes.about),
                      child: const Text('Saiba mais sobre Quem Somos →'),
                    )
                  ],
                ),
              ),

              // RODAPÉ
              Container(
                color: const Color(0xFF0F341D), // Tom ligeiramente mais escuro mantido para profundidade do footer
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    const Text('Sistema Capiba Verde', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('Acumule pontos cuidando do ecossistema e troque por benefícios sustentáveis locais.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
                    const Divider(color: Colors.white24, height: 40),
                    const Text('© 2026 Bora Cultivar - Recife. Todos os direitos reservados.', style: TextStyle(color: Colors.white38, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: const FloraFloatingButton(),
    );
  }

  Widget _buildStepCard(String step, String title, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppTheme.accentGreen, // Puxando do AppTheme
          child: Text(step, style: const TextStyle(color: Colors.white)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }
}