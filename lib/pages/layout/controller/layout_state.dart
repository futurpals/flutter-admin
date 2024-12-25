import 'package:flutter/material.dart';
import 'package:flutter_iot_web/pages/ai/ai_page.dart';
import 'package:flutter_iot_web/pages/auth/auth_page.dart';
import 'package:flutter_iot_web/pages/home/home_page.dart';
import 'package:get/get.dart';

import '../../../route/router.dart';
import '../../sn/sn_page.dart';
import '../component/sidebar/admin_menu_item.dart';

class LayoutState {
  var extended = true.obs;
  final GlobalKey tabsKey = GlobalKey();
  var menuItems = <AdminMenuItem>[
    AdminMenuItem(
      title: '概率',
      path: Routes.home,
      icon: Icons.home,
    ),
    AdminMenuItem(
      title: 'AI管理',
      path: Routes.ai,
      icon: Icons.people,
    ),
    AdminMenuItem(
      title: 'SN管理',
      path: Routes.sn,
      icon: Icons.dashboard,
    ),
    AdminMenuItem(
      title: '用户管理',
      path: Routes.auth,
      icon: Icons.dashboard,
    ),
    AdminMenuItem(
        title: '测试页面',
        path: Routes.test,
        icon: Icons.dashboard,
        children: [
          AdminMenuItem(
            title: '测试页面-1',
            path: Routes.test_1,
            icon: Icons.dashboard,
          ),
        ]),
    AdminMenuItem(
        title: '测试页面-2',
        path: Routes.test_2,
        icon: Icons.dashboard,
        children: [
          AdminMenuItem(
              title: '测试页面-3',
              path: Routes.test_3,
              icon: Icons.dashboard,
              children: [
                AdminMenuItem(
                  title: '测试页面-4',
                  path: Routes.test_4,
                  icon: Icons.dashboard,
                ),
                AdminMenuItem(
                  title: '测试页面-5',
                  path: Routes.test_5,
                  icon: Icons.dashboard,
                ),
              ]),
        ]),
  ].obs;
  var selectedRoute = Rxn<AdminMenuItem>();
  var tabsItems = <AdminMenuItem>[].obs;
  final ScrollController scrollController = ScrollController();
}
