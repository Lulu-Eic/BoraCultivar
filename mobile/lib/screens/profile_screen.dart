import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../core/routes/app_routes.dart';
import '../core/theme/app_theme.dart'; // Agora este import está sendo usado!

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        final user = auth.user;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Perfil'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _buildProfileHeader(context, user),
                const SizedBox(height: 32),
                _buildStatsSection(context),
                const SizedBox(height: 32),
                _buildMenuSection(context, auth),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(BuildContext context, Map<String, dynamic>? user) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: AppTheme.accentGreen.withValues(alpha: 0.15),
              backgroundImage: user?['foto_perfil'] != null
                  ? NetworkImage(user!['foto_perfil'] as String)
                  : null,
              child: user?['foto_perfil'] == null
                  ? const Icon(Icons.person,
                      size: 40, color: AppTheme.primaryGreen)
                  : null,
            ),
            const SizedBox(height: 16),
            Text(user?['nome'] as String? ?? 'Usuário',
                style: Theme.of(context).textTheme.titleLarge),
            Text(user?['email'] as String? ?? '',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.editProfile),
              icon: const Icon(Icons.edit, size: 16),
              label: const Text('Editar Perfil'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildStatCard(context, '5', 'Solicitações')),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard(context, '12', 'Árvores Plantadas')),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String value, String label) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppTheme.primaryGreen,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context, AuthProvider auth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Configurações',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.primaryGreen,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        _buildMenuItem(context, Icons.history, 'Minhas Solicitações',
            () => Navigator.of(context).pushNamed(AppRoutes.status)),
        _buildMenuItem(context, Icons.notifications, 'Notificações', () {}),
        _buildMenuItem(context, Icons.help, 'Ajuda e Suporte', () {}),
        _buildMenuItem(context, Icons.info, 'Sobre o Bora Cultivar',
            () => Navigator.of(context).pushNamed(AppRoutes.about)),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              auth.logout();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
            },
            icon: const Icon(Icons.logout),
            label: const Text('Sair'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.primaryGreen,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, color: AppTheme.primaryGreen),
              const SizedBox(width: 16),
              Expanded(
                  child: Text(title,
                      style: Theme.of(context).textTheme.titleMedium)),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
