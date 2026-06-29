import 'package:get/get.dart';
import '../../features/auth/presentation/login/binding/login_binding.dart';
import '../../features/auth/presentation/forgot_password/binding/forgot_password_binding.dart';
import '../../features/auth/presentation/signup_step/add_mobile_number/binding/add_mobile_number_binding.dart';
import '../../features/home/presentation/home/binding/home_binding.dart';
import '../bindings/app_bindings.dart';
import 'routes.dart';
import 'routes_config.dart';

List<GetPage> routesHandler = [
  GetPage(
    name: BaseRoute.splash,
    page: () => RoutesConfig.splash,
    binding: SplashBinding(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: BaseRoute.onBoarding,
    page: () => RoutesConfig.onBoarding,
    binding: OnboardingBinding(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: BaseRoute.login,
    page: () => RoutesConfig.login,
    binding: LoginBinding(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: BaseRoute.forgotPassword,
    page: () => RoutesConfig.forgotPassword,
    binding: ForgotPasswordBinding(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: BaseRoute.signUp,
    page: () => RoutesConfig.signUp,
    binding: AddMobileNumberBinding(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: BaseRoute.homeScreen,
    page: () => RoutesConfig.homeScreen,
    binding: HomeBinding(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: BaseRoute.profileScreen,
    page: () => RoutesConfig.profileScreen,
    binding: ProfileBinding(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: BaseRoute.productDetailScreen,
    page: () => RoutesConfig.productDetailScreen,
    binding: ProductDetailsBinding(),
    transition: Transition.fadeIn,
  ),
];
