import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_iot_web/app.dart';
import 'package:flutter_iot_web/utils/logger.dart';
import 'package:flutter_iot_web/utils/sp_utils.dart';


Future<void> main() async {
  await SpUtils.init();
  Log.d('start run app');
  runApp(const FlutterAdmin());
}
