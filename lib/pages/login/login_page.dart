import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_iot_web/pages/login/component/login_btn.dart';
import 'package:flutter_iot_web/pages/login/component/login_text_field.dart';
import 'package:flutter_iot_web/pages/responsive.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_iot_web/base/constants.dart';
import 'dart:ui';

import '../../route/router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final dropDownKey = GlobalKey<DropdownSearchState>();
  bool _isRemember = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: Responsive.isMobile(context)
          ? const EdgeInsets.symmetric(horizontal: 32)
          : null,
      child: Row(
        children: [
          if (Responsive.isDesktop(context))
            Expanded(
              // It takes 5/6 part of the screen
              flex: 6,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          accentBgColor.withAlpha(60),
                          accentBgColor.withAlpha(20),
                          primaryColor.withAlpha(20),
                          accentBgColor.withAlpha(40),
                          accentBgColor.withAlpha(60),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.all(20.0),
                                child: Image.asset(
                                    width: 30, 'assets/images/logo.png'),
                              ),
                              const Text(
                                'Futurpals',
                                style: TextStyle(
                                    fontFamily: 'EDIX',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                      Expanded(
                        flex: 9,
                        child: Container(
                            child: Lottie.asset(
                          'assets/lottie/iot_1.json',
                          width: 380,
                          fit: BoxFit.fitWidth,
                        )).animate().fadeIn(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          Flexible(
              // It takes 5/6 part of the screen
              flex: 4,
              child: Center(
                child: SizedBox(
                  width: 390,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  '欢迎回来',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                Lottie.asset(
                                  "assets/lottie/welcome.json",
                                  height: 120,
                                  width: 190,
                                  fit: BoxFit.fill,
                                ),
                              ],
                            )),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 38),
                          child: Text(
                            '请输入您的帐户信息以开始管理您的项目',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: DropdownSearch<String>(
                            key: dropDownKey,
                            selectedItem: "中国大陆",
                            items: (filter, infiniteScrollProps) =>
                                ["中国大陆", "欧洲", "美国"],
                            decoratorProps: const DropDownDecoratorProps(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFE4E4E7)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                              ),
                            ),
                            popupProps: const PopupProps.menu(
                                menuProps: MenuProps(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                                listViewProps: ListViewProps(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                ),
                                fit: FlexFit.loose,
                                constraints: BoxConstraints()),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: LoginTextField(hintText: '请输入用户名'),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: LoginTextField(
                              hintText: '请输入密码',
                              isPassword: true,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: _isRemember,
                                    // 初始勾选状态
                                    activeColor: Colors.blue,
                                    // 勾选时的颜色
                                    checkColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide(width: 0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6.0)),
                                    ),
                                    onChanged: (bool? value) {
                                      if (mounted) {
                                        setState(() {
                                          _isRemember = value!;
                                        });
                                      }
                                    },
                                    splashRadius: 2,
                                  ),
                                  const Text('记住帐号'),
                                ],
                              ),
                              const Text('忘记密码?'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: LoginButton(
                            text: '登录',
                            onPress: () {
                              Get.offNamed(Routes.layout);
                            },
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: LoginButton(
                                          text: '手机号登录',
                                          color: Colors.white,
                                          focusColor: const Color(0xFFF5F4F5),
                                          borderColor: const Color(0xFFE4E4E7),
                                          textColor: Colors.black,
                                          borderWidth: 1,
                                          onPress: () {},
                                        ))),
                                Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: LoginButton(
                                          text: '扫码登录',
                                          color: Colors.white,
                                          focusColor: const Color(0xFFF5F4F5),
                                          borderColor: const Color(0xFFE4E4E7),
                                          textColor: Colors.black,
                                          borderWidth: 1,
                                          onPress: () {},
                                        ))),
                              ],
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '还没有帐户?',
                              style: TextStyle(fontSize: 12),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                '创建帐号',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        )
                      ]),
                ),
              )),
        ],
      ),
    ));
  }
}
