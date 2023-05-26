import 'package:get/get.dart';

import '../bindings/dashboard_binding.dart';
import '../bindings/login_binding.dart';
import '../bindings/chatting_binding.dart';
import '../modules/chatting/chatting_view.dart';
import '../modules/dashboard/dashboard_view.dart';
import '../modules/login/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.CHATTING,
      page: () => const ChattingView(),
      binding: ChattingBinding(),
    ),
  ];
}
