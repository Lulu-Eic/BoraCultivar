// lib/widgets/flora_floating_button.dart
import 'package:flutter/material.dart';

class FloraFloatingButton extends StatelessWidget {
  const FloraFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xFF14532D),
      child: const Icon(Icons.park, color: Color(0xFF22C55E), size: 30),
      onPressed: () {
        Navigator.pushNamed(context, '/chatbot');
      },
    );
  }
}