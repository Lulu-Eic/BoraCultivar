import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Importando o pacote de mídia
import '../core/routes/app_routes.dart';
import '../core/theme/app_theme.dart';

class RequestPlantingScreen extends StatelessWidget {
  const RequestPlantingScreen({super.key});

  // Método responsável por abrir a Câmera ou a Galeria
  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 1080, // Limita o tamanho para não pesar no banco/memória
        imageQuality: 85,
      );

      // Se o usuário tirou a foto ou selecionou uma com sucesso
      if (pickedFile != null) {
        if (context.mounted) {
          // Navega para o formulário passando o caminho do arquivo como argumento
          Navigator.pushNamed(
            context, 
            AppRoutes.form, 
            arguments: pickedFile.path,
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao acessar a mídia: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitar Plantio'), 
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        foregroundColor: AppTheme.primaryGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Primeiro, vamos verificar se o local escolhido atende os requisitos técnicos. Escolha uma das opções abaixo:', 
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: _buildOptionCard(
                    context, 
                    Icons.camera_alt_outlined, 
                    'Verificação ao Vivo', 
                    'Use sua câmera para verificar o local em tempo real. Ideal para uma análise instantânea.',
                    'Iniciar Câmera',
                    () {
                      _pickImage(context, ImageSource.camera);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildOptionCard(
                    context, 
                    Icons.file_upload_outlined, 
                    'Enviar Foto', 
                    'Envie uma foto do local que deseja arborizar. Ideal se você já tem uma imagem salva.',
                    'Escolher Foto',
                    () {
                      _pickImage(context, ImageSource.gallery);
                    },
                  ),
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.primaryGreen),
                  backgroundColor: const Color(0xFFF4F9F4), // Fundo levemente esverdeado igual ao layout
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Vai direto, sem passar argumentos de imagem
                  Navigator.pushNamed(context, AppRoutes.form);
                },
                child: const Text(
                  'Pular verificação e ir direto ao formulário', 
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context, 
    IconData icon, 
    String title, 
    String body,
    String buttonText,
    VoidCallback onPressed,
  ) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 48, color: AppTheme.primaryGreen),
            const SizedBox(height: 12),
            Text(
              title, 
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), 
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              body, 
              style: const TextStyle(fontSize: 12, color: Colors.black54), 
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                minimumSize: const Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: onPressed,
              icon: Icon(
                icon == Icons.camera_alt_outlined ? Icons.camera_alt : Icons.upload, 
                size: 14, 
                color: Colors.white,
              ),
              label: Text(
                buttonText, 
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}