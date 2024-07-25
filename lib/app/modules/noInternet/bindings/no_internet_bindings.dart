import 'package:getx/app/modules/noInternet/controller/no_internet_controller.dart';
import 'package:get/get.dart';

class NoInternetBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NoInternetController());
  }
}
