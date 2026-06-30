import 'package:fieldtrack/app/routes/routes.dart';
import 'package:fieldtrack/app/routes/routes_config.dart';
import 'package:fieldtrack/features/auth/presentation/login/binding/login_binding.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../../features/auth/presentation/sign_up/bindings/signup_binding.dart';
import '../../features/dashboard/binding/dashboard_binding.dart';

List<GetPage> routesHandler = [
  GetPage(
    name: BaseRoute.login,
    page: () => RoutesConfig.login,
    binding: LoginBinding(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: BaseRoute.signUp,
    page: () => RoutesConfig.signUp,
    binding: SignUpBinding(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: BaseRoute.dashboard,
    page: () => RoutesConfig.dashboard,
    binding: DashboardBinding(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: BaseRoute.homeScreen,
    page: () => RoutesConfig.homeScreen,
    transition: Transition.fadeIn,
  ),
];
