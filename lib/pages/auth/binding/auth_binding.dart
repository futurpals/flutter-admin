import 'package:flutter_iot_web/pages/auth/controller/auth_controller.dart';
import 'package:get/get.dart';


class AuthBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<AuthController>(
        () => AuthController(),
      )
    ];
  }
}
