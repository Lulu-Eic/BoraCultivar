import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ChatService {
  // 1. URL de produção (Render)
  static const String _prodUrl = 'https://bora-cultivar-api.onrender.com';

  // 2. Ajuste para o Emulador: 10.0.2.2 é o padrão para Android
  static const String _devUrl =
      kIsWeb ? 'http://localhost:3000' : 'http://10.0.2.2:3000';

  // 3. Getter inteligente
  static String get _baseUrl => kReleaseMode ? _prodUrl : _devUrl;

  Future<String> sendMessageToFlora(String message) async {
    final url = Uri.parse('$_baseUrl/chat');

    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'message': message}),
          )
          .timeout(const Duration(seconds: 40));

      if (response.statusCode == 200) {
        // Uso de utf8.decode para garantir caracteres especiais como ç e ã
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return data['reply']?.toString() ?? 'Flora está pensativa...';
      }

      return 'Servidor indisponível (Erro ${response.statusCode})';
    } on http.ClientException catch (e) {
      // Diferencia erro de rede de outros erros
      debugPrint("Erro de conexão HTTP: $e");
      return 'Erro de conexão: Verifique se o servidor está online.';
    } on Exception catch (e) {
      if (e.toString().contains('TimeoutException')) {
        return 'A Flora demorou a responder. O servidor pode estar "acordando". Tente novamente!';
      }
      debugPrint("Erro inesperado: $e");
      return 'Erro inesperado: Ocorreu um problema ao comunicar com a Flora.';
    }
  }
}
