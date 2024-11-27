import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:reels_app/UI/common/common_loading_dialog.dart';
import 'package:reels_app/UI/common/common_snackbar.dart';
import 'package:reels_app/infrastructure/constant/app_constant.dart';
import 'package:reels_app/infrastructure/storage/shared_preference_service.dart';
import 'package:reels_app/infrastructure/utils/notification_manager.dart';
import 'package:reels_app/infrastructure/utils/utils.dart';
import 'package:http/http.dart' as http;

class RingtoneDownloader{

  static var methodChannel = const MethodChannel("com.demo.methodchannel");

  static loadData(String filePath){
    try {
      methodChannel.invokeMethod('refreshMedia', {
        "filePath": filePath
      });
    } on PlatformException catch (e) {
      Exception("Failed to Invoke: '${e.message}'.");
    }
  }

  static _downloadRingtone(String url) async {
    try {

      final http.Response response = await http.get(Uri.parse(getImageLink(url: url)));

      final dir = Platform.isAndroid ? File("/storage/emulated/0/Ringtones") : await getApplicationSupportDirectory();

      var filePath = '${dir.path}/Gen Z';
      var fileName = '${DateTime.now().millisecondsSinceEpoch}.mp3';

      File ringtonePath = File("$filePath/$fileName");

      if (await Directory(filePath).exists()) {
        await ringtonePath.writeAsBytes(response.bodyBytes);
      } else {
        await Directory(filePath).create(recursive: true);
        await ringtonePath.writeAsBytes(response.bodyBytes);
      }

      if(Platform.isAndroid){
        loadData(ringtonePath.path);
      }
      if(await SharedPreferenceService.getShowNotification){
        NotificationManager.showCompletedNotification(category: "Ringtone",filePath: "");
      }
    } on PlatformException catch (e) {
      Exception(e);
      log("Error Downloading ==> $e");
    }
  }

  static downloadRingtone(String url,GestureTapCallback onDownloadComplete) async {

    onDownloadComplete();
    showLoadingDialog();
  }

  static _shareRingtone(String url) async{
    final http.Response response = await http.get(Uri.parse(getImageLink(url: url)));

    final dir = await getTemporaryDirectory();

    var filePath = dir.path;
    var fileName = "${DateTime.now().millisecondsSinceEpoch}.mp3";

    File ringtonePath = File("$filePath/$fileName");

    await ringtonePath.writeAsBytes(response.bodyBytes);

    final result = await Share.shareXFiles([XFile(ringtonePath.path)],text: AppConstants.shareAppTxt);

    log("filePath : ${ringtonePath.path}");

    Get.back();
    if (result.status == ShareResultStatus.success) {
      log('Thank you for sharing the picture!');
    }
  }

  static shareRingtone(String url) async{
    showLoadingDialog();

  }
}