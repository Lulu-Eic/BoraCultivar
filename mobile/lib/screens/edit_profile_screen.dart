import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../providers/auth_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers para os campos de texto
  late TextEditingController _nomeController;
  late TextEditingController _emailController;
  late TextEditingController _senhaAtualController;
  late TextEditingController _novaSenhaController;
  late TextEditingController _confirmarSenhaController;

  // Estados dos Checkboxes
  bool _notifPlantio = true;
  bool _notifReclamacoes = false;
  bool _notifCupons = true;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthProvider>().user;
    _nomeController = TextEditingController(text: user?['nome'] ?? '');
    _emailController = TextEditingController(text: user?['email'] ?? '');
    _senhaAtualController = TextEditingController();
    _novaSenhaController = TextEditingController();
    _confirmarSenhaController = TextEditingController();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaAtualController.dispose();
    _novaSenhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Link Voltar ao Perfil
                TextButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back,
                      size: 16, color: Colors.grey),
                  label: const Text('Voltar ao perfil',
                      style: TextStyle(color: Colors.grey)),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Editar Perfil',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGreen),
                ),
                const SizedBox(height: 32),

                // Campo Nome
                _buildLabel('Nome completo'),
                TextFormField(
                  controller: _nomeController,
                  decoration:
                      _inputStyle(Icons.person_outline, 'Digite seu nome'),
                ),
                const SizedBox(height: 20),

                // Campo Email
                _buildLabel('Email'),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _inputStyle(
                    Icons.email_outlined,
                    'usuario@email.com',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe um email';
                    }

                    final emailRegex = RegExp(
                      r'^[\w\.-]+@[\w\.-]+\.\w+$',
                    );

                    if (!emailRegex.hasMatch(value)) {
                      return 'Email inválido';
                    }

                    return null;
                  },
                ),

                _buildLabel('Senha atual'),
                TextFormField(
                  controller: _senhaAtualController,
                  obscureText: true,
                  decoration: _inputStyle(
                    Icons.lock_outline,
                    'Digite sua senha atual',
                  ),
                ),

                const SizedBox(height: 20),

                _buildLabel('Nova senha'),
                TextFormField(
                  controller: _novaSenhaController,
                  obscureText: true,
                  decoration: _inputStyle(
                    Icons.lock_reset,
                    'Digite a nova senha',
                  ),
                ),

                const SizedBox(height: 20),

                _buildLabel('Confirmar nova senha'),
                TextFormField(
                  controller: _confirmarSenhaController,
                  obscureText: true,
                  decoration: _inputStyle(
                    Icons.lock_outline,
                    'Repita a nova senha',
                  ),
                ),

                // Seção Notificações
                const Row(
                  children: [
                    Icon(Icons.notifications_outlined,
                        color: AppTheme.primaryGreen, size: 20),
                    SizedBox(width: 8),
                    Text('Preferências de notificações',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 12),
                _buildCheckboxTile(
                    'Receber atualizações do plantio',
                    _notifPlantio,
                    (val) => setState(() => _notifPlantio = val!)),
                _buildCheckboxTile(
                    'Receber atualizações de reclamações de árvores',
                    _notifReclamacoes,
                    (val) => setState(() => _notifReclamacoes = val!)),
                _buildCheckboxTile(
                    'Notificações de cupons e outros prêmios (moeda Capiba)',
                    _notifCupons,
                    (val) => setState(() => _notifCupons = val!)),

                const SizedBox(height: 40),

                // Botão Salvar
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveChanges,
                    child: const Text('Salvar alterações'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(label,
          style: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black87)),
    );
  }

  InputDecoration _inputStyle(IconData icon, String hint) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.grey),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!)),
    );
  }

  Widget _buildCheckboxTile(
      String title, bool value, Function(bool?) onChanged) {
    return CheckboxListTile(
      title: Text(title, style: const TextStyle(fontSize: 14)),
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: AppTheme.primaryGreen,
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }

 void _saveChanges() async {
  print('BOTAO CLICADO');

  if (!_formKey.currentState!.validate()) {
    print('FORMULARIO INVALIDO');
    return;
  }

  final user = context.read<AuthProvider>().user;

  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Usuário não encontrado'),
      ),
    );
    return;
  }

  final success = await context.read<AuthProvider>().updateUser({
    'id': user['id'],
    'nome': _nomeController.text.trim(),
    'email': _emailController.text.trim(),
    'novaSenha': _novaSenhaController.text,
  });

  print('SUCCESS = $success');

  if (mounted && success) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Alterações salvas com sucesso!'),
        backgroundColor: AppTheme.primaryGreen,
      ),
    );

    Navigator.pop(context);
  }
}
}
