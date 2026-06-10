import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
// CORREÇÃO 4: Import apontava para '../screens/perfil_page.dart', que não existe
//             no projeto. A tela de perfil chama-se profile_screen.dart /
//             ProfileScreen. Corrigido o caminho e o nome da classe.
import '../screens/profile_screen.dart';
import 'auth_text_field.dart';
 
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}
 
class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _loginKey = GlobalKey<FormState>();
  final _emailLogin = TextEditingController();
  final _passLogin = TextEditingController();
 
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
 
  // CORREÇÃO 5: Controllers nunca eram descartados, causando vazamento de memória.
  @override
  void dispose() {
    _tabController.dispose();
    _emailLogin.dispose();
    _passLogin.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bora Cultivar'),
        // CORREÇÃO 6: TabBar estava ausente do AppBar — o TabBarView existia mas
        //             não havia controle visual de abas para o usuário alternar.
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Entrar'),
            Tab(text: 'Cadastrar'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Aba Login
          Form(
            key: _loginKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                AuthTextField(
                  controller: _emailLogin,
                  label: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Informe o e-mail' : null,
                ),
                const SizedBox(height: 12),
                AuthTextField(
                  controller: _passLogin,
                  label: 'Senha',
                  icon: Icons.lock,
                  obscure: true,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Informe a senha' : null,
                ),
                const SizedBox(height: 20),
                Consumer<AuthProvider>(
                  builder: (ctx, auth, _) => ElevatedButton(
                    onPressed: auth.isLoading
                        ? null
                        : () async {
                            if (_loginKey.currentState!.validate()) {
                              try {
                                await auth.login(
                                  _emailLogin.text.trim(),
                                  _passLogin.text.trim(),
                                );
                                if (ctx.mounted) {
                                  Navigator.pushReplacement(
                                    ctx,
                                    MaterialPageRoute(
                                      builder: (_) => const ProfileScreen(),
                                    ),
                                  );
                                }
                              } catch (e) {
                                if (ctx.mounted) {
                                  ScaffoldMessenger.of(ctx).showSnackBar(
                                    SnackBar(content: Text(e.toString())),
                                  );
                                }
                              }
                            }
                          },
                    child: auth.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Entrar'),
                  ),
                ),
              ],
            ),
          ),
 
          // Aba Cadastro — redireciona para FormScreen
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/form'),
              child: const Text('Criar nova conta'),
            ),
          ),
        ],
      ),
    );
  }
}
