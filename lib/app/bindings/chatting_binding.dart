import 'package:get/get.dart';

import '../modules/chatting/chatting_controller.dart';

class ChattingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChattingController>(
      () => ChattingController(),
    );
  }
}
