import 'package:flutter/material.dart';
import 'package:flutter_iot_web/base/constants.dart';
import 'package:flutter_iot_web/lang/translation_service.dart';
import 'package:flutter_iot_web/utils/logger.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'route/router.dart';

class FlutterAdmin extends StatelessWidget {
  const FlutterAdmin({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'IoT Admin',
      theme: ThemeData(
        primaryColor: primaryColor,
        canvasColor: canvasColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
      ),
      locale: TranslationService.locale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        // add other library integrated locals
      ],
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
      getPages: AppRouter.routes,
      // routerDelegate: _createDelegate(),
      // routerDelegate: _createDelegate(),
      // onInit: () {
      //   final delegate = Get.rootController.rootDelegate;
      //   delegate.navigatorObservers?.add(GetObserver(null, Get.routing));
      // },
    );
  }

  GetDelegate _createDelegate() {
    try {
      return GetDelegate(
        pages: AppRouter.routes,
        navigatorObservers: <NavigatorObserver>[
          //GetObserver(null, Routing()),
        ],
        pickPagesForRootNavigator: (currentNavStack) {
          final actives = Get.rootController.rootDelegate.activePages;
          final pages = <GetPage>[];
          for (var p in actives) {
            if (p != currentNavStack && p.route?.maintainState != true) {
              continue;
            }
            final q = p.currentTreeBranch.lastWhere(
                (e) => e.participatesInRootNavigator == true,
                orElse: () => p.route!);
            if (pages.contains(q)) {
              pages.remove(q);
            }
            pages.add(q);
          }
          Get.log('picked root pages: ${pages.map((e) => e.name)}');
          return pages;
        },
      );
    } catch (e) {
      Log.i(e);
    }
    return GetDelegate(pages: []);
  }
}
