import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class Utilities {
  static void setWindowSize() {
    if (Platform.isWindows) {
      doWhenWindowReady(() {
        final win = appWindow;
        const initialSize = Size(1200, 700);
        win.minSize = initialSize;
        win.size = initialSize;
        win.alignment = Alignment.center;
        win.title = "Internet Application";
        win.show();
      });
    }
  }

  static Future<String> getDownloadPath() async {
    var downloadPath = await getDownloadsDirectory();
    if (downloadPath != null) {
      Logger().i(downloadPath.path);
      return downloadPath.path;
    } else {
      throw PathNotFoundException;
    }
  }

  static String getTime() {
    final DateTime time = DateTime.now();
    return "${time.year}_${time.day}_${time.month}_${time.microsecond}";
  }
}
