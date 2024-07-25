import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../modules/select_language/controller/language_controller.dart';

class Constants {
  static Duration kDuration = const Duration(seconds: 3);
  static const delayTime = Duration(seconds: 3);
  static const quicksandFont = "Quicksand";
  static const nunito = "Nunito";
  static DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  static DateFormat dateFormat24 = DateFormat("yyyy-MM-dd HH:mm:ss");
  static DateFormat timeFormat = DateFormat("HH:mm:ss");
  static String currencySymbol = "tk";
  static String reminderText =
      "You will get a warning when you’ve reached 50%, 80%, 90% left of your budget.";
  static String overspentText =
      "You will get a warning when you’ve exceeded 100% of your budget.";

  static var lanList = [
    LanguageModel(
      id: "English",
      languageCode: "en",
      countryCode: "US",
      lanugaeName: "English",
    ),
    LanguageModel(
        id: "Bangla",
        languageCode: "bn",
        countryCode: "BN",
        lanugaeName: "বাংলা"),
    LanguageModel(
        id: "Japanese",
        languageCode: "jp",
        countryCode: "JP",
        lanugaeName: "日本語"),
    LanguageModel(
        id: "Espaniol",
        languageCode: "es",
        countryCode: "ES",
        lanugaeName: "Español"),
    LanguageModel(
        id: "French",
        languageCode: "fr",
        countryCode: "FR",
        lanugaeName: "Français"),
    LanguageModel(
        id: "Hindi",
        languageCode: "hi",
        countryCode: "HI",
        lanugaeName: "हिंदी"),
    LanguageModel(
        id: "Arabic",
        languageCode: "ar",
        countryCode: "AR",
        lanugaeName: "عربي"),
  ];

  //for ads
  //android
  static String androidAppId = 'ca-app-pub-3018789677887592~3000754191';
  static String androidBannerAd = 'ca-app-pub-3018789677887592/5587335180';
  static String androidInterstitialAd = 'ca-app-pub-3018789677887592/6517273474';
  //ios
  static String iOsAppId = 'ca-app-pub-3018789677887592~5052202468';
  static String iOsBannerAd = 'ca-app-pub-3018789677887592/5543420383';
  static String iOsInterstitialAd = 'ca-app-pub-3018789677887592/3197809715';
}

//for shop card
Gradient fixedGradient = const RadialGradient(
    radius: 1,
    focalRadius: 1,
    stops: [0.5, 0.7],
    center: Alignment.topLeft,
    tileMode: TileMode.mirror,
    colors: [
      Color(0xffE5E5E5),
      Color(0xffA3A3A3),
    ]
);
// for 2 button in one line
Gradient buttonRadialGradient = const RadialGradient(
    radius: 1.4,
    focalRadius: 0.4,
    focal: Alignment.centerLeft,
    stops: [0.1, 1],
    center: Alignment.topLeft,
    tileMode: TileMode.mirror,
    colors: [
      Color(0xffA3A3A3),
      Color(0xffE5E5E5),
    ]
);

// for button and textField
Gradient buttonTextFieldRadialGradient = const RadialGradient(
    radius: 2.0,
    focalRadius: 0,
    focal: Alignment.centerLeft,
    stops: [0.1, 0.8],
    center: Alignment.topLeft,
    tileMode: TileMode.mirror,
    colors: [
      Color(0xffA3A3A3),
      Color(0xffE5E5E5),
    ]
);

/// Box Shadow...
defaultBoxShadow(double value) => <BoxShadow>[
  BoxShadow(
    color: Colors.grey.withOpacity(0.05),
    blurRadius: 6,
    offset: Offset(value, value),
  ),
  BoxShadow(
    color: Colors.grey.withOpacity(0.1),
    blurRadius: 6,
    offset: Offset(-value, -value),
  ),
];
zeroPxBoxShadow({double value = 0}) => <BoxShadow>[
  BoxShadow(
    color: Colors.grey.withOpacity(0.2),
    blurRadius: 4,
    offset: Offset(value, value),
  ),
];
zeroPxBoxShadowWithDark({double value = 0}) => <BoxShadow>[
  BoxShadow(
    color: Colors.black.withOpacity(0.25),
    blurRadius: 4,
    offset: Offset(value, value),
  ),
];
/// Default box decoration...
BoxDecoration defaultBoxDecoration() {
  return BoxDecoration(
    boxShadow: defaultBoxShadow(3),
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
  );
}
