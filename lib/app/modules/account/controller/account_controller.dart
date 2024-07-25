import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx/app/modules/signIn/controller/sign_in_controller.dart';
import 'package:getx/app/modules/signIn/model/user_login_response_model.dart';

class AccountController extends GetxController {
  final loginController = Get.find<LoginController>();

  UserLoginResponseModel? get userInfo => loginController.user;

  var fullNameController = TextEditingController();
  var emailController = TextEditingController();

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  void loadData(){
    fullNameController.text = "${userInfo?.user.fullName}";
    emailController.text = "${userInfo?.user.email}";
  }
}