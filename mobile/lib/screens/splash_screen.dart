// lib/screens/splash_screen.dart
import 'dart:async'; // Import necessário para o Timer automático
import 'package:flutter/material.dart';
import '../core/routes/app_routes.dart';
import '../core/theme/app_theme.dart'; // Import do seu tema centralizado

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  Timer? _autoNavTimer; // Timer para controle de navegação automática

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _opacityAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(_controller);

    // Navegação automática após 4 segundos (mude o tempo se preferir)
    _autoNavTimer = Timer(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    });
  }

  @override
  void dispose() {
    _autoNavTimer?.cancel(); // Cancela o timer se o usuário sair antes dos 4s
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Substituído pela cor principal do seu arquivo AppTheme
      backgroundColor: AppTheme.primaryGreen, 
      body: GestureDetector(
        onTap: () {
          _autoNavTimer?.cancel(); // Cancela a automação pois o usuário clicou voluntariamente
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomPaint(
                size: const Size(150, 150),
                painter: TreePainter(),
              ),
              const SizedBox(height: 40),
              const Text(
                'Bora\nCultivar?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFE2F0D9),
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'ARBORIZAÇÃO URBANA · RECIFE',
                style: TextStyle(
                  color: Color(0xFF8BAE84),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 80),
              FadeTransition(
                opacity: _opacityAnimation,
                child: const Text(
                  'Toque para entrar ●',
                  style: TextStyle(color: Color(0xFF8BAE84), fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TreePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final trunkPaint = Paint()..color = const Color(0xFF7A431D);
    final leafPaint1 = Paint()..color = const Color(0xFF3B7A57);
    final leafPaint2 = Paint()..color = const Color(0xFF4CAF50);
    final leafPaint3 = Paint()..color = const Color(0xFF81C784);

    // Tronco
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.45, size.height * 0.6, size.width * 0.1, size.height * 0.4),
      trunkPaint,
    );
    // Círculos da copa da árvore estilizada
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.55), size.width * 0.35, leafPaint1);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.42), size.width * 0.28, leafPaint2);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.30), size.width * 0.20, leafPaint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}