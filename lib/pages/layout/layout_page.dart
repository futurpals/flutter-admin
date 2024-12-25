import 'package:flutter/material.dart';
import 'package:flutter_iot_web/pages/layout/controller/layout_controller.dart';
import 'package:flutter_iot_web/pages/layout/layout_scaffold.dart';
import 'package:get/get.dart';

import 'route_page.dart';
import 'component/sidebar/side_bar.dart';
import 'component/layout_tabs/layout_tabs.dart';

class LayoutPage extends GetView<LayoutController> {
  @override
  Widget build(BuildContext context) {
    return LayoutScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [const LayoutTabs(), RoutePage()],
      ),
      appBar: AppBar(
        title: Obx(() => controller.getLateralPath(
              const TextStyle(fontSize: 13, color: Color(0xFF717179)),
            )),
        backgroundColor: Colors.white,
        toolbarHeight: 50,
        actions: [],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.black12,
            height: 0.5, // 边框厚度
          ),
        ),
      ),
      sideBar: SideBar(
        backgroundColor: Colors.white,
        activeBackgroundColor: Colors.black26,
        borderColor: Colors.black12,
        iconColor: Colors.black87,
        activeIconColor: Colors.blue,
        textStyle: const TextStyle(
          color: Color(0xFF337ab7),
          fontSize: 13,
        ),
        activeTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 13,
        ),
        header: Container(
          height: 50,
          width: double.infinity,
          color: Colors.white,
          child: Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(width: 30, 'assets/images/logo.png'),
              ),
              const Text(
                'Futurpals',
                style: TextStyle(
                  fontFamily: 'EDIX',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: Colors.white,
          child: const Center(
            child: Text(
              'footer',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
