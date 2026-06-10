// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  // Paleta de cores oficial extraída do design do app
  static const Color primaryGreen = Color(0xFF14532D); // Verde Escuro Principal
  static const Color accentGreen = Color(0xFF22C55E); // Verde Vivo (Capiba)
  static const Color backgroundLight = Color(0xFFF0F4F1); // Fundo Off-white

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryGreen,
      scaffoldBackgroundColor: backgroundLight,

      // 1. Garante a consistência da tipografia em todas as telas
      fontFamily: 'Roboto',

      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        primary: primaryGreen,
        secondary: accentGreen,
      ),

      // 3. Ajuste nos campos de texto (Login, Cadastro e Formulários)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors
            .white, // Deixa o fundo do input branco para destacar no scaffold
        prefixIconColor:
            primaryGreen, // Força os ícones dos campos a ficarem verdes
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryGreen, width: 2),
        ),
        labelStyle: const TextStyle(color: primaryGreen),
      ),

      // 2. Ajuste nos botões (com tratamento para estados ativos/desativados)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          disabledBackgroundColor:
              Colors.grey[300], // Cor caso o botão esteja desativado
          disabledForegroundColor: Colors.grey[600],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
