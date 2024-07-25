import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDbHelper {
  Database? _database;
  static LocalDbHelper? _financeDbHelper;

  String categoryTable = 'categoryTable';
  String subCategoryTable = 'subCategoryTable';

  //........... category column ...........
  String colPId = 'pId';
  String colId = 'id';
  String colName = 'name';
  String colStatus = 'status';
  String colType = 'type';

  //........... sub category column ...........
  String colSubPId = 'pId';
  String colSubId = 'id';
  String colSubName = 'name';
  String colSubStatus = 'status';
  String colSubType = 'type';
  String colSubCategoryId = 'category_id';
  String colSubImageUrl = 'image_url';

  LocalDbHelper._createInstance();

  static final LocalDbHelper db = LocalDbHelper._createInstance();

  factory LocalDbHelper() {
    _financeDbHelper ??= LocalDbHelper._createInstance();
    return _financeDbHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    if (!path.endsWith("/")) {
      path = "$path/";
    }
    path = '${path}budgetdayplan.db';
    var myDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return myDatabase;
  }

  //........... notification columns ...........
  String notificationTable = "notifications";
  String colNotificationPId = 'pId';
  String colNotificationTitle = 'title';
  String colNotificationMessage = 'message';
  String colNotificationType = 'type';
  String colNotificationData = 'data';
  String colNotificationCreatedAt = 'created_at';
  String colNotificationIsShow = 'is_show';
  String colNotificationImageUrl = 'image_url';

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $categoryTable"
        "($colPId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$colId INTEGER, $colName TEXT, $colStatus INTEGER, $colType INTEGER)");
    await db.execute("CREATE TABLE $subCategoryTable"
        "($colSubPId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$colSubId INTEGER, $colSubName TEXT, $colSubStatus INTEGER, "
        "$colSubType INTEGER, $colSubCategoryId INTEGER, $colSubImageUrl TEXT)");
    await db.execute("CREATE TABLE $notificationTable"
        "($colNotificationPId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$colNotificationTitle TEXT, $colNotificationMessage TEXT, "
        "$colNotificationType TEXT, $colNotificationData TEXT, $colNotificationCreatedAt TEXT, $colNotificationIsShow INTEGER, "
        "$colNotificationImageUrl TEXT)");
  }
}
