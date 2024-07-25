import 'package:getx/app/modules/main_page/binding/main_page_binding.dart';
import 'package:getx/app/modules/main_page/main_screen.dart';
import 'package:getx/app/modules/signIn/binding/sign_in_binding.dart';
import 'package:getx/app/modules/signIn/sign_in_screen.dart';
import 'package:getx/app/modules/splash/bindings/splash_bidings.dart';
import 'package:getx/app/routes/routes.dart';
import 'package:get/get.dart';
import '../modules/noInternet/bindings/no_internet_bindings.dart';
import '../modules/noInternet/no_internet.dart';
import '../modules/select_language/controller/language_bindings.dart';
import '../modules/select_language/select_language.dart';
import '../modules/signup/binding/signup_binding.dart';
import '../modules/signup/signup_screen.dart';
import '../modules/splash/splash.dart';

class Pages {
  static final pages = [
    GetPage(
      name: Routes.initial,
      page: () => const SplashScreen(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: Routes.noInternet,
      page: () => const NoInternetPage(),
      binding: NoInternetBindings(),
    ),
    GetPage(
      name: Routes.login,
      binding: SignInBinding(),
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.signup,
      page: () => const RegisterScreen(),
      binding: SignupBinding(),
    ),

    GetPage(
      name: Routes.mainScreen,
      page: () => const MainScreen(),
      bindings: [
        MainPageBinding(),
      ],
    ),
    GetPage(
      name: Routes.selectLanguage,
      page: () => const SelectLanguage(),
      binding: LanguageBindings(),
    ),
  ];
}
