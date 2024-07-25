import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getx/app/core/app_colors.dart';
import 'package:getx/app/core/app_sizes.dart';
import 'package:getx/app/core/utils.dart';
import 'package:getx/app/service/db_helper.dart';
import 'package:getx/app/service/init.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/bindings/app_bindings.dart';
import 'app/core/shared_preference.dart';
import 'app/modules/splash/splash.dart';
import 'app/routes/pages.dart';
import 'app/service/language_string.dart';

late final SharedPreferences sharedPreferences;
late final LocalDbHelper localDbHelper;
//flutter build apk --release --target-platform=android-arm64

void main() async {
  await AppInitializer().init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return GetMaterialApp(
      routingCallback: (routing) {},
      debugShowCheckedModeBanner: false,
      title: 'Safi Health',
      locale: Utils.fetchLocale(),
      translations: LocalString(),
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primarySwatch: AppColors.appColor,
        hoverColor: AppColors.appColor,
        primaryColor: AppColors.appColor,
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.appColor,
          textTheme: ButtonTextTheme.normal,
          disabledColor: AppColors.greyColor,
        ),
        fontFamily: "Quicksand",
        dividerTheme: DividerThemeData(color: AppColors.greyColor),
        appBarTheme: AppBarTheme(
            titleTextStyle: GoogleFonts.biryani(
                color: Colors.black,
                textStyle: const TextStyle(fontWeight: FontWeight.w500))),
        dialogBackgroundColor: Colors.white,
        dialogTheme: DialogTheme(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: AppColors.deppBlue,
        ),
      ),
      initialBinding: AppBindings(),
      transitionDuration: const Duration(milliseconds: 300),
      defaultTransition: Transition.cupertino,
      home: const SplashScreen(),
      // home: const TransactionScreen(),
      getPages: Pages.pages,
    );
  }
}
