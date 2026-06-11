import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Retorna o usuário como um Map para compatibilidade com os controllers de UI
  Map<String, dynamic>? get user {
    final u = Supabase.instance.client.auth.currentUser;
    if (u == null) return null;
    return {
      'id': u.id,
      'email': u.email,
      'nome': u.userMetadata?['nome'] ?? '',
    };
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _authService.login(email, password);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(String nome, String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _authService.register(nome, email, password);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateUser(Map<String, dynamic> dados) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _authService.updateUserProfile(
        nome: dados['nome'],
        email: dados['email'],
        novaSenha: dados['novaSenha'],
      );
      notifyListeners(); // Força a atualização dos componentes que usam 'user'
      return true;
    } catch (e) {
      debugPrint("Erro na atualização: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    _authService.logout();
    notifyListeners();
  }
}