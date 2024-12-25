import 'package:get/get.dart';

import '../controller/ai_controller.dart';

class AiBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<AiController>(
        () => AiController(),
      )
    ];
  }
}
