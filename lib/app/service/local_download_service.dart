import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadService {
  static String defaultPath =
      "/storage/emulated/0/Android/data/day-planner/files";
  static Future<String> getDirPath() async {
    String? externalStoragePath;
    try {
      if (Platform.isIOS || Platform.isMacOS) {
        // Directory? directory = await getDownloadsDirectory();
        // Directory? directory = await getLibraryDirectory();
        Directory? directory = await getApplicationDocumentsDirectory();
        externalStoragePath = directory.path;
        if (kDebugMode) {
          print("getDirPath");
        }
      } else {}
    } catch (error) {
      if (Platform.isIOS || Platform.isMacOS) {
        Directory? directory = await getApplicationDocumentsDirectory();
        externalStoragePath = directory.path;
        if (kDebugMode) {
          print("error getDirPath");
        }
      } else {
        final directory = await getExternalStorageDirectory();
        externalStoragePath = directory?.path ?? defaultPath;
      }
    }
    debugPrint('Document path: $externalStoragePath');
    return externalStoragePath ?? "";
  }

  static Future<void> savePdfFile(
      List<int> bytes, String fileName, apiLevel, context) async {
    await Permission.mediaLibrary.request();
    final dirPath = await getDirPath();
    Directory directory = Directory(dirPath);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    if (await directory.exists()) {
      try {
        String filePath = "${directory.path}/$fileName";
        print(filePath);

        File file = File(filePath);
        await file.writeAsBytes(bytes, flush: true);
        Get.snackbar("Message", "Download Completed");
      } catch (e) {
        print(e.toString());
      }
    } else {
      Get.snackbar("Message", "Failed To Save Pdf");
    }
  }
}
