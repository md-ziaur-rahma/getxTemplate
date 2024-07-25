import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:getx/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/contants.dart';
import '../../../core/shared_preference.dart';
import '../../../core/utils.dart';
import '../../signIn/controller/sign_in_controller.dart';

class NoInternetController extends GetxController {
  var isLoading = false.obs;
  final LoginController _loginController = Get.find<LoginController>();

  checkInternet() async {
    isLoading(true);
    debugPrint("check internet working");
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.bluetooth ||
        connectivityResult == ConnectivityResult.ethernet) {
      return Timer(Constants.kDuration, jumpToLogin);
    } else {
      debugPrint("No internet");
      Utils.showSnackBar(message: "No Internet!");
      isLoading(false);
    }
  }

  Future jumpToLogin() async {
    if (_loginController.isLoggedIn) {
      final isLangageAvailable =
      await MySharedPreference.chekcLanguageSetOrNot();
      if (isLangageAvailable) {
        _loginController.setUserName(_loginController.user?.user.firstName ?? "",
            _loginController.user?.user.picture ?? "");
        Get.offAllNamed(Routes.mainScreen);
      } else {
        Get.offAllNamed(Routes.selectLanguage);
      }
    } else {
      Get.offAllNamed(Routes.login);
    }
  }
}
