import 'package:flutter/material.dart';

import '../../features/auth/presentation/login/view/login_screen.dart';
import '../../features/auth/presentation/sign_up/view/signup_screen.dart';
import '../../features/dashboard/view/dashboard_screen.dart';
import '../../features/home/presentation/home/view/home_screen.dart';

class RoutesConfig {
  static const splash = Center(child: Text('Splash'));
  static const onBoarding = Center(child: Text('Onboarding'));
  static const login = LoginScreen();
  static const signUp = SignUpScreen();
  static const verifyOtp = Center(child: Text('Verify OTP'));
  static final dashboard = DashboardScreen();
  static const homeScreen = HomeScreen();
  static const profileScreen = Center(child: Text('Profile'));
  static const productDetailScreen = Center(child: Text('Product Detail'));
  static const virtualCard = Center(child: Text('Virtual Card'));
  static const addMoney = Center(child: Text('Add Money'));
  static const myOrder = Center(child: Text('My Order'));
  static const cart = Center(child: Text('Cart'));
  static const wishlist = Center(child: Text('Wishlist'));
  static const settings = Center(child: Text('Settings'));
}
