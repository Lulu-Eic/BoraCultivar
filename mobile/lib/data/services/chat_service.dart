// lib/data/services/chat_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
 
class ChatService {
  // Detecta automaticamente o ambiente correto:
  // - Emulador Android usa 10.0.2.2 para chegar ao localhost do PC
  // - iOS Simulator e Web usam localhost normalmente
  static String get _baseUrl {
    if (kIsWeb) return 'http://localhost:3000';
    if (Platform.isAndroid) return 'http://10.0.2.2:3000';
    return 'http://localhost:3000';
  }
 
  Future<String> sendMessageToFlora(String message) async {
    final url = Uri.parse('$_baseUrl/chat');
 
    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'message': message}),
          )
          .timeout(
            const Duration(seconds: 20),
            onTimeout: () => throw Exception('timeout'),
          );
 
      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            jsonDecode(utf8.decode(response.bodyBytes));
        return data['reply'] as String? ??
            'Flora está pensativa... Tente novamente. 🌿';
      }
 
      // Trata erros do backend com mensagens amigáveis
      if (response.statusCode == 503) {
        final Map<String, dynamic> data =
            jsonDecode(utf8.decode(response.bodyBytes));
        return '⚠️ ${data['error'] ?? 'Serviço temporariamente indisponível.'}';
      }
 
      return 'Erro na comunicação com a Flora (Status: ${response.statusCode})';
    } on Exception catch (e) {
      if (e.toString().contains('timeout')) {
        return 'A Flora demorou para responder. Verifique sua conexão e tente novamente. 🌿';
      }
      return 'Não consegui conectar ao servidor. Verifique sua conexão. 🌿';
    }
  }
}