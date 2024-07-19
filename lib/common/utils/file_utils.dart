import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<String> saveFile(String tempPath, String? oldPath) async {
  try {
    if (!await _requestStoragePermissions()) {
      return tempPath;
    }

    Directory dir = await getApplicationDocumentsDirectory();
    String imagesDir = '${dir.path}/images';
    if (!(await Directory(imagesDir).exists())) {
      await Directory(imagesDir).create();
    }
    final newPath =
        '$imagesDir/${DateTime.now().millisecondsSinceEpoch}.${tempPath.split('.').last}';
    if (oldPath != null && oldPath.isNotEmpty) {
      File f = File(oldPath);
      if (await f.exists()) {
        await f.delete();
      }
    }
    await File(tempPath).copy(newPath);
    return newPath;
  } catch (e) {
    debugPrint(e.toString());
    return tempPath;
  }
}

Future<bool> _requestStoragePermissions() async {
  var status = await Permission.storage.request();
  if (status.isGranted) {
    return true;
  }
  return false;
}

Future<void> deleteFile(String? path) async {
  try {
    if (path != null && path.isNotEmpty) {
      File f = File(path);
      if (await f.exists()) {
        await f.delete();
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}

Future<void> deleteAllImages() async {
  Directory dir = await getApplicationDocumentsDirectory();
  String imagesDir = '${dir.path}/images';
  if (await Directory(imagesDir).exists()) {
    await Directory(imagesDir).delete(recursive: true);
  }
}
