import 'package:get/get.dart';

import '../controller/sn_controller.dart';

class SnBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<SnController>(
        () => SnController(),
      )
    ];
  }
}
