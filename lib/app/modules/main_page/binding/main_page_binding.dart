import 'package:get/get.dart';
import 'package:getx/app/modules/account/controller/account_controller.dart';
import 'package:getx/app/modules/home/controller/home_controller.dart';
import 'package:getx/app/modules/main_page/controller/main_controller.dart';
import 'package:getx/app/modules/signIn/controller/sign_in_controller.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(Get.find()));
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => AccountController());
  }
}