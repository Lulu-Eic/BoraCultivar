import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // <--- IMPORTANTE: Adicione este import
import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';
import 'providers/auth_provider.dart'; // <--- Importe o seu provider
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url:
        'https://cpfvrqfhgyagnekctpmx.supabase.co', // Obtenha no painel do Supabase
    publishableKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNwZnZycWZoZ3lhZ25la2N0cG14Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODEwOTUwMjYsImV4cCI6MjA5NjY3MTAyNn0.Ar0PXJ1ZuZk5FF34JX4rmUtIG7lJcLJRUheuUs0qHgs', // Obtenha no painel do Supabase
  );

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
