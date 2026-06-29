import 'package:flutter/material.dart';

import '../../features/auth/presentation/forgot_password/view/forgot_password_screen.dart';
import '../../features/auth/presentation/login/view/login_screen.dart';
import '../../features/auth/presentation/signup_step/add_mobile_number/view/add_mobile_number_screen.dart';
import '../../features/home/presentation/home/view/home_screen.dart';

class RoutesConfig {
  static const splash = Center(child: Text('Splash'));
  static const onBoarding = Center(child: Text('Onboarding'));
  static const login = LoginScreen();
  static const forgotPassword = ForgotPasswordScreen();
  static const signUp = AddMobileNumberScreen();
  static const verifyOtp = Center(child: Text('Verify OTP'));
  static const dashboard = Center(child: Text('Dashboard'));
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
