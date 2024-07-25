import 'package:getx/app/service/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../core/contants.dart';
import '../core/shared_preference.dart';
import '../modules/signIn/model/user_login_response_model.dart';
import '../modules/signup/model/region_model.dart';
import 'error/exception.dart';

abstract class LocalDataSource {
  UserLoginResponseModel getUserResponseModel();
  Future<bool> cacheUserResponse(UserLoginResponseModel userLoginResponseModel);

  Future<int> getTableRowCount(tableName);
  Future<void> viewedNotification(int id);
  Future<void> deleteNotificationOffline(int id);

  //for local notification
  Future<bool> checkIsNotificationActive();
  Future<void> setNotificationActive(bool data);

  //.............. language ..............
  Future<bool> saveLanguage(String languages);
  Future<String> getLanguage();

  Future<bool> userLogout();

  //region
  Future<bool> saveRegionData(RegionModel regionModel);
  RegionModel getRegionData();
  bool isCachedRegionData();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;
  final LocalDbHelper localDbHelper;

  LocalDataSourceImpl(
    this.sharedPreferences,
    this.localDbHelper,
  );

  @override
  Future<bool> cacheUserResponse(
      UserLoginResponseModel userLoginResponseModel) {
    return sharedPreferences.setString(
      MySharedPreference.cachedUserResponseKey,
      userLoginResponseModel.toRawJson(),
    );
  }

  @override
  UserLoginResponseModel getUserResponseModel() {
    final jsonString =
        sharedPreferences.getString(MySharedPreference.cachedUserResponseKey);
    if (jsonString != null) {
      return UserLoginResponseModel.fromRawJson(jsonString);
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }

  @override
  Future<int> getTableRowCount(tableName) async {
    sqflite.Database db = await localDbHelper.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $tableName');
    int result = sqflite.Sqflite.firstIntValue(x) ?? 0;
    return result;
  }

  @override
  Future<void> viewedNotification(int id) async {
    sqflite.Database db = await localDbHelper.database;
    final batch = db.batch();
    batch.update(localDbHelper.notificationTable,
        {localDbHelper.colNotificationIsShow: 1},
        where: '${localDbHelper.colNotificationPId} = ?', whereArgs: [id]);
    await batch.commit();
  }

  @override
  Future<void> deleteNotificationOffline(int id) async {
    sqflite.Database db = await localDbHelper.database;
    final batch = db.batch();
    batch.delete(localDbHelper.notificationTable,
        where: '${localDbHelper.colNotificationPId} = ?', whereArgs: [id]);
    await batch.commit();
  }

  //notification
  static const String notificationValue = "notificationValue";
  static const String currency = "currency";
  static const String languageCode = 'languageCode';

  @override
  Future<bool> checkIsNotificationActive() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    bool result = localStorage.getBool(notificationValue) ?? false;
    return result;
  }

  @override
  Future setNotificationActive(bool data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setBool(notificationValue, data);
  }

  @override
  Future<bool> saveLanguage(String languages) {
    return sharedPreferences.setString(
        MySharedPreference.cachedLanguageKey, languages);
  }

  @override
  Future<String> getLanguage() async {
    final language =
        sharedPreferences.getString(MySharedPreference.cachedLanguageKey);
    return language ?? "English";
  }

  @override
  Future<bool> userLogout() async {
    return sharedPreferences.remove(MySharedPreference.cachedUserResponseKey);
  }
  //Region
  @override
  Future<bool> saveRegionData(RegionModel regionModel) {
    return sharedPreferences.setString(
      MySharedPreference.saveRegionData,
      regionModel.toRawJson(),
    );
  }

  @override
  RegionModel getRegionData() {
    final jsonString =
    sharedPreferences.getString(MySharedPreference.saveRegionData);
    if (jsonString != null) {
      return RegionModel.fromRawJson(jsonString);
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }

  @override
  bool isCachedRegionData() {
    final jsonString =
    sharedPreferences.getString(MySharedPreference.saveRegionData);
    if (jsonString != null) {
      RegionModel regionModel = RegionModel.fromRawJson(jsonString);
      String today =Constants.dateFormat.format(DateTime.now());
      if (today == regionModel.saveDate) {
        return true;
      }
      return false;
    } else {
      return false;
    }
  }

}
