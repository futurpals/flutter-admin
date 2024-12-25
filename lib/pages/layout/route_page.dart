import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../route/router.dart';
import '../../utils/logger.dart';
import 'controller/layout_controller.dart';

class RoutePage extends StatelessWidget {
  RoutePage({super.key});

  LayoutController layoutCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetRouterOutlet.builder(
        route: Routes.layout,
        builder: (context) {
          return Scaffold(
            body: GetRouterOutlet(
              initialRoute: Routes.home,
              anchorRoute: Routes.layout,
              filterPages: (pages) {
                var ret = pages.toList();
                try {
                  if (ret.isEmpty && ModalRoute.of(context)!.isCurrent) {
                    ret.add(context.delegate.matchRoute(Routes.home).route!);
                  }
                  final nav = Get.nestedKey(Routes.layout)
                      ?.navigatorKey
                      .currentState
                      ?.widget;
                  Get.log('Home filter pages: ${pages.map((e) => e.name)}');

                  if (nav != null) {
                    if (ret.isEmpty) {
                      Get.log("Home use olds: ${nav.pages.map((e) => e.name)}");
                      return nav.pages as List<GetPage>;
                    }
                    final sn = ret[0].name.split('/').length;
                    for (var p in nav.pages as List<GetPage>) {
                      if (p.maintainState &&
                          p.name.split('/').length == sn &&
                          !ret.contains(p)) {
                        ret.insert(0, p);
                      }
                    }
                  }
                  ret = ret
                      .where((e) => e.participatesInRootNavigator != true)
                      .toList();
                  String pathName = pages.last.name;
                  Log.i(pathName);
                  Get.log('Home real pages: ${ret.map((e) => e.name)}');
                  layoutCtrl.onNavByNative(pathName, context);
                } catch (e) {
                  Log.i(e);
                }
                return ret;
              },
            ),
          );
        },
      ),
    );
  }
}
