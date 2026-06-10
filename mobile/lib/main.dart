import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // <--- IMPORTANTE: Adicione este import
import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';
import 'providers/auth_provider.dart'; // <--- Importe o seu provider

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const CapibaVerdeApp(),
    ),
  );
}

class CapibaVerdeApp extends StatelessWidget {
  const CapibaVerdeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bora Cultivar?',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash, 
      routes: AppRoutes.routes,
    );
  }
}