// lib/core/routes/app_routes.dart
import 'package:flutter/material.dart';
import '../../../screens/splash_screen.dart';
import '../../../screens/home_screen.dart';
import '../../../screens/auth_screen.dart';
import '../../../screens/about_screen.dart';
import '../../../screens/status_screen.dart';
import '../../../screens/request_planting_screen.dart';
import '../../../screens/form_screen.dart';
import '../../../screens/chatbot_screen.dart';
import '../../screens/edit_profile_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String auth = '/auth';
  static const String about = '/about';
  static const String status = '/status';
  static const String requestPlanting = '/request_planting';
  static const String form = '/form';
  static const String chatbot = '/chatbot';
  static const String editProfile = '/edit_profile';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => const SplashScreen(),
      home: (context) => const HomeScreen(),
      auth: (context) => const AuthScreen(),
      about: (context) => const AboutScreen(),
      status: (context) => const StatusScreen(),
      requestPlanting: (context) => const RequestPlantingScreen(),
      form: (context) => const FormScreen(),
      chatbot: (context) => const ChatbotScreen(),
      editProfile: (context) => const EditProfileScreen(),
    };
  }
}
