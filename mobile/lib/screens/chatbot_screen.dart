import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../data/services/chat_service.dart'; // Importando o novo serviço

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatService _chatService = ChatService(); // Instanciando o serviço de IA
  
  bool _isLoading = false; // Estado para mostrar animação de "digitando..."

  final List<Map<String, dynamic>> _messages = [
    {
      'isUser': false,
      'text': 'Oi, eu sou a Flora 🍃. Posso te ajudar a realizar uma vistoria ou tirar dúvidas sobre o plantio de árvores no Recife hoje?',
    }
  ];

  // Função auxiliar para rolar a conversa sempre para a última mensagem
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _isLoading) {
      return;
    }

    setState(() {
      _messages.add({'isUser': true, 'text': text});
      _messageController.clear();
      _isLoading = true; // Ativa o indicador de carregamento
    });
    _scrollToBottom();

    // Chamada real HTTP para a API Node.js/Express
    final botResponse = await _chatService.sendMessageToFlora(text);

    // Validação de segurança para garantir que o usuário não saiu da tela durante o await
    if (!mounted) {
      return;
    }

    setState(() {
      _messages.add({'isUser': false, 'text': botResponse});
      _isLoading = false; // Desativa o indicador
    });
    _scrollToBottom();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            CircleAvatar(
              backgroundColor: AppTheme.accentGreen, 
              radius: 14, 
              child: Icon(Icons.park, size: 16, color: Colors.white),
            ),
            SizedBox(width: 8),
            Text('Conversar com Flora'),
          ],
        ),
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Corpo do Chat com scroll automático integrado
          Expanded(
            child: ListView.builder(
              controller: _scrollController, // Vinculando o controlador de rolagem
              padding: const EdgeInsets.all(24),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final bool isUser = msg['isUser'];

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isUser ? AppTheme.primaryGreen : Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isUser ? 16 : 0),
                        bottomRight: Radius.circular(isUser ? 0 : 16),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Text(
                      msg['text'],
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Indicador visual de carregamento "Flora está pensando..."
          if (_isLoading) ...[
            Padding(
              padding: const EdgeInsets.only(left: 24.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Flora está digitando...',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12, fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          
          // BARRA DE INPUT DO CHAT
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    onSubmitted: (_) {
                      _sendMessage();
                    }, 
                    decoration: const InputDecoration(
                      hintText: 'Digite sua mensagem para a Flora...',
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.mic, color: Colors.grey),
                  onPressed: () {},
                ),
                CircleAvatar(
                  backgroundColor: AppTheme.primaryGreen,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 18),
                    onPressed: _sendMessage,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}