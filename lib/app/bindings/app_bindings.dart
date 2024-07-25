import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:getx/app/modules/splash/controller/splash_controller.dart';
import 'package:getx/app/service/db_helper.dart';
import 'package:getx/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/local_database.dart';
import '../data/remote_database.dart';
import '../modules/signIn/controller/sign_in_controller.dart';
import '../modules/signIn/repo/auth_repository.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() async {
    Get.lazyPut<Client>(() => Client());
    Get.lazyPut<SharedPreferences>(() => sharedPreferences);
    Get.lazyPut<LocalDbHelper>(() => localDbHelper);
    Get.lazyPut<RemoteDataSource>(
        () => RemoteDataSourceImpl(client: Get.find()));
    Get.lazyPut<LocalDataSource>(
        () => LocalDataSourceImpl(Get.find(), Get.find()));
    Get.lazyPut(() => SplashController());
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(
        remoteDataSource: Get.find(), localDataSource: Get.find()));
    Get.lazyPut(() => LoginController(Get.find()));
  }
}
