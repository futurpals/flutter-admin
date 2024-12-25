import 'package:flutter/material.dart';
import 'package:flutter_iot_web/pages/ai/controller/ai_controller.dart';
import 'package:get/get.dart';

class AiPage extends GetView<AiController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      decoration: const BoxDecoration(
        color: Color(0xfff1f3f5),
      ),
      padding: const EdgeInsets.all(10),
      child: const Text(
        'AI',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 36,
        ),
      ),
    );
  }
}
