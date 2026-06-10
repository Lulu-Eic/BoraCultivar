// lib/data/services/auth_service.dart
import 'package:dio/dio.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  // Ajuste o IP conforme necessário (Android Studio usa 10.0.2.2)
  static String get _baseUrl => kIsWeb
      ? 'http://localhost:3000/api'
      : (Platform.isAndroid
          ? 'http://192.168.0.100:3000/api'
          : 'http://localhost:3000/api');

  final Dio _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: const Duration(seconds: 20),
    validateStatus: (status) =>
        status != null && status < 500, // Não lançar exceção para erro 400
  ));

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _dio.post('/auth/login', data: {
      'email': email.trim().toLowerCase(),
      'senha': password,
    });

    if (response.statusCode == 200) return response.data;
    throw Exception(response.data['error'] ?? 'Erro no login');
  }

  Future<void> register(String nome, String email, String password) async {
    final response = await _dio.post('/auth/registrar', data: {
      'nome': nome,
      'email': email.trim().toLowerCase(),
      'senha': password,
    });

    if (response.statusCode != 201) {
      throw Exception(response.data['error'] ?? 'Erro no registro');
    }
  }
Future<Map<String, dynamic>> updateUser(
  Map<String, dynamic> dados,
) async {
  final response = await _dio.put(
    '/auth/perfil',
    data: dados,
  );

  print('STATUS: ${response.statusCode}');
  print('DATA: ${response.data}');
  print('TIPO DATA: ${response.data.runtimeType}');

  if (response.statusCode == 200) {
    return Map<String, dynamic>.from(response.data);
  }

  throw Exception(
    response.data['error'] ?? 'Erro ao atualizar usuário',
  );
}
}
