import 'package:get/get.dart';

import '../controller/layout_controller.dart';

class LayoutBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<LayoutController>(
        () => LayoutController(),
      )
    ];
  }
}
