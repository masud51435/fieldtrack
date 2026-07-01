import 'package:flutter/material.dart';

import '../../features/auth/presentation/login/view/login_screen.dart';
import '../../features/auth/presentation/sign_up/view/signup_screen.dart';
import '../../features/dashboard/view/dashboard_screen.dart';
import '../../features/home/presentation/view/home_screen.dart';
import '../../features/user_profile/presentation/view/profile_screen.dart';

class RoutesConfig {
  static const splash = Center(child: Text('Splash'));
  static const login = LoginScreen();
  static const signUp = SignUpScreen();
  static final dashboard = DashboardScreen();
  static const homeScreen = HomeScreen();
  static const profileScreen = ProfileScreen();
}
