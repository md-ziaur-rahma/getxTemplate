import 'package:get/get.dart';

import 'language_controller.dart';

class LanguageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LanguageController());
  }
}
