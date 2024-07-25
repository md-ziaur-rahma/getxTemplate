import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:getx/app/core/contants.dart';
import 'package:getx/app/modules/signIn/controller/sign_in_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:getx/app/core/contants.dart';
import 'package:getx/app/modules/signIn/controller/sign_in_controller.dart';

import '../../../core/shared_preference.dart';
import '../../../routes/routes.dart';

class SplashController extends GetxController {
  var isLoading = false.obs;
  final LoginController _loginController = Get.find<LoginController>();

  @override
  void onInit() {
    startTime();
    super.onInit();
  }

  Future startTime() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.first == ConnectivityResult.mobile ||
        connectivityResult.first == ConnectivityResult.wifi) {
      return Timer(Constants.delayTime, jumpToLogin);
    } else {
      return Timer(Constants.delayTime, noInternetPage);
    }
  }

  Future jumpToLogin() async {
    if (kDebugMode) {
      print(_loginController.isLoggedIn);
    }
    if (_loginController.isLoggedIn) {
      final isLanguageAvailable =
          await MySharedPreference.chekcLanguageSetOrNot();
      if (isLanguageAvailable) {
      _loginController.setUserName(_loginController.user?.user.firstName ?? "",
          _loginController.user?.user.picture ?? "");

      Get.offAllNamed(Routes.mainScreen);
      } else {
        Get.offAllNamed(Routes.mainScreen);
        // Get.offAllNamed(Routes.selectLanguage);
      }
    } else {
      Get.offAllNamed(Routes.login);
    }
  }

  void noInternetPage() {
     Get.offAllNamed(Routes.noInternet);
  }
}
