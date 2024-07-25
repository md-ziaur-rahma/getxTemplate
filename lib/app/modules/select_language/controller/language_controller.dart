import 'dart:async';
import 'package:getx/app/core/contants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../main.dart';
import '../../../core/shared_preference.dart';
import '../../../routes/routes.dart';

class LanguageController extends GetxController {
  var selectedCode = "English".obs;
  var isFirstTime = 0.obs;
  var isLoading = false.obs;
  var local = const Locale('en', 'US').obs;

  @override
  void onInit() {
    selectLanguage();
    super.onInit();
  }

  List<LanguageModel> langaugeList = Constants.lanList;

  Future setLanguage() async {
    isLoading(true);
    Get.updateLocale(local.value);
    await MySharedPreference.setCacheLangauge(selectedCode.value);
    if (isFirstTime.value == 0) {
      isLoading(false);
      Get.back();
    } else {
      return Timer(const Duration(milliseconds: 1000), navigateToHomePage);
    }
  }

  selectLanguage() async {
    final String localeCode =
        sharedPreferences.getString(MySharedPreference.cachedLanguageKey) ??
            'English';
    isFirstTime.value =
        sharedPreferences.getString(MySharedPreference.cachedLanguageKey) ==
                null
            ? 1
            : 0;
    selectedCode(localeCode);
  }

  void navigateToHomePage() {
    isLoading(false);
    Get.offAllNamed(Routes.mainScreen);
  }
}

class LanguageModel {
  String id;
  String languageCode;
  String countryCode;
  String lanugaeName;

  LanguageModel(
      {required this.id,
      required this.languageCode,
      required this.countryCode,
      required this.lanugaeName});
}
