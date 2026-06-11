import 'package:supabase_flutter/supabase_flutter.dart';



class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> login(String email, String password) async {
    await _supabase.auth.signInWithPassword(
      email: email.trim().toLowerCase(),
      password: password,
    );
  }

  Future<void> register(String nome, String email, String password) async {
    await _supabase.auth.signUp(
      email: email.trim().toLowerCase(),
      password: password,
      data: {'nome': nome},
    );
  }

  Future<void> updateUserProfile({String? nome, String? email, String? novaSenha}) async {
    final attributes = UserAttributes(
      email: email,
      password: novaSenha,
      data: nome != null ? {'nome': nome} : null,
    );
    await _supabase.auth.updateUser(attributes);
  }

  Future<void> logout() async {
    await _supabase.auth.signOut();
  }
}