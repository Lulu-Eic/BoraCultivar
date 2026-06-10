import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  // IP padrão para o Emulador Android conseguir enxergar o localhost do seu PC.
  // Se estiver testando em um celular físico conectado no Wi-Fi, mude para o IP do seu computador (ex: 192.168.1.X).
  static const String _baseUrl = 'http://10.0.2.2:3000';

  Future<String> sendMessageToFlora(String message) async {
    final url = Uri.parse('$_baseUrl/chat');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'message': message, // Body esperado pelo seu chatController.js
        }),
      );

      if (response.statusCode == 200) {
        // Decodifica a resposta vinda do backend { "reply": "..." }
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['reply'] ?? 'Flora está pensativa... Tente novamente.';
      } else {
        return 'Erro na comunicação com a Flora (Status: ${response.statusCode})';
      }
    } catch (e) {
      return 'Não consegui conectar ao servidor do Bora Cultivar. Verifique sua conexão.';
    }
  }
}