import 'package:flutter_iot_web/pages/ai/binding/ai_binding.dart';
import 'package:flutter_iot_web/pages/auth/binding/auth_binding.dart';
import 'package:flutter_iot_web/pages/home/binding/home_binding.dart';
import 'package:flutter_iot_web/pages/home/home_page.dart';
import 'package:flutter_iot_web/pages/login/binding/login_binding.dart';
import 'package:flutter_iot_web/pages/login/login_page.dart';
import 'package:flutter_iot_web/pages/sn/binding/sn_binding.dart';
import 'package:flutter_iot_web/pages/sn/sn_page.dart';
import 'package:get/get.dart';

import '../pages/ai/ai_page.dart';
import '../pages/auth/auth_page.dart';
import '../pages/layout/binding/layout_binding.dart';
import '../pages/layout/layout_page.dart';

abstract class Routes {
  static const layout = _Paths.layout;
  static const login = _Paths.login;

  static const home = _Paths.layout + _Paths.home;
  static const settings = _Paths.layout + _Paths.settings;
  static const ai = _Paths.layout + _Paths.ai;
  static const sn = _Paths.layout + _Paths.sn;
  static const auth = _Paths.layout + _Paths.auth;

  static const test = _Paths.layout + _Paths.test;
  static const test_1 = _Paths.layout + _Paths.test + _Paths.test_1;
  static const test_2 = _Paths.layout + _Paths.test_2;
  static const test_3 = _Paths.layout + _Paths.test_2 + _Paths.test_3;
  static const test_4 =
      _Paths.layout + _Paths.test_2 + _Paths.test_3 + _Paths.test_4;
  static const test_5 =
      _Paths.layout + _Paths.test_2 + _Paths.test_3 + _Paths.test_5;

  Routes._();
}

abstract class _Paths {
  static const layout = '/layout';

  static const home = '/home';
  static const settings = '/settings';
  static const login = '/login';
  static const ai = '/ai';
  static const sn = '/sn';
  static const auth = '/auth';

  static const test = '/test';
  static const test_1 = '/test_1';
  static const test_2 = '/test_2';
  static const test_3 = '/test_3';
  static const test_4 = '/test_4';
  static const test_5 = '/test_5';
}

class AppRouter {
  AppRouter._();

  static const initial = Routes.layout;

  static final routes = [
    GetPage(
      name: _Paths.layout,
      preventDuplicates: true,
      participatesInRootNavigator: true,
      page: () => LayoutPage(),
      bindings: [
        LayoutBinding(),
      ],
      title: null,
      children: [
        GetPage(
          name: _Paths.ai,
          page: () => AiPage(),
          bindings: [
            AiBinding(),
          ],
        ),
        GetPage(
          name: _Paths.auth,
          page: () => AuthPage(),
          bindings: [
            AuthBinding(),
          ],
        ),
        GetPage(
          name: _Paths.home,
          page: () => HomePage(),
          bindings: [
            HomeBinding(),
          ],
        ),
        GetPage(
          name: _Paths.sn,
          page: () => SnPage(),
          bindings: [
            SnBinding(),
          ],
        ),
        GetPage(
          name: _Paths.test,
          participatesInRootNavigator: false,
          page: () => SnPage(),
          bindings: [
            SnBinding(),
          ],
          children: [
            GetPage(
              name: _Paths.test_1,
              page: () => SnPage(),
              bindings: const [],
            ),
          ],
        ),
        GetPage(
          name: _Paths.test_2,
          participatesInRootNavigator: false,
          page: () => SnPage(),
          bindings: [
            SnBinding(),
          ],
          children: [
            GetPage(
              name: _Paths.test_3,
              participatesInRootNavigator: false,
              page: () => SnPage(),
              bindings: const [],
              children: [
                GetPage(
                  name: _Paths.test_4,
                  page: () => SnPage(),
                  bindings: const [],
                ),
                GetPage(
                  name: _Paths.test_5,
                  page: () => SnPage(),
                  bindings: const [],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GetPage(
      name: _Paths.login,
      participatesInRootNavigator: true,
      page: () => const LoginPage(),
      bindings: [
        LoginBinding(),
      ],
    ),
  ];
}
