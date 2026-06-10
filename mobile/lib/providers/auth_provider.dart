// CORREÇÃO 1: Imports obrigatórios estavam ausentes — ChangeNotifier e AuthService
//             nunca foram importados, causando erro de compilação imediato.
import 'package:flutter/foundation.dart';
import '../data/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  Map<String, dynamic>? _user;
  bool _isLoading = false;

  Map<String, dynamic>? get user => _user;
  bool get isLoading => _isLoading;

  // CORREÇÃO 2: Bloco try sem catch deixava exceções silenciosas.
  //             A exceção agora é relançada para que a UI exiba o erro.
  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      final data = await _authService.login(email, password);
      _user = data['usuario'];
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // CORREÇÃO 12 (complemento): Método register ausente no provider, mas chamado
  //                             pelo FormScreen. Adicionado delegando ao AuthService.
  Future<void> register(String nome, String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _authService.register(nome, email, password);
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // CORREÇÃO 3: logout ausente, necessário para ProfileScreen.
  void logout() {
    _user = null;
    notifyListeners();
  }

  Future<bool> updateUser(
    Map<String, dynamic> dados,
  ) async {
    try {
      final usuarioAtualizado = await _authService.updateUser(dados);

      print('RETORNO UPDATE: $usuarioAtualizado');
      print('TIPO RETORNO: ${usuarioAtualizado.runtimeType}');

      _user = usuarioAtualizado;

      notifyListeners();

      return true;
    } catch (e, s) {
      print('ERRO UPDATE USER => $e');
      print(s);

      return false;
    }
  }
}
