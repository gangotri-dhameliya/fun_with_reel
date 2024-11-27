import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:reels_app/UI/common/common_loading_dialog.dart';
import 'package:reels_app/UI/common/common_snackbar.dart';
import 'package:reels_app/infrastructure/constant/app_constant.dart';
import 'package:reels_app/infrastructure/storage/shared_preference_service.dart';
import 'package:reels_app/infrastructure/utils/notification_manager.dart';
import 'package:http/http.dart' as http;
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reels_app/infrastructure/utils/utils.dart';

class ImageDownloader{

  static var methodChannel = const MethodChannel("com.demo.methodchannel");

  static _downloadImage(String imageUrl) async {
    // if(Platform.isAndroid){
    //   debugPrint("----------android downloading");
    //   try {
    //     methodChannel.invokeMethod('downloadWallpaper', {
    //       "imageUrl": imageUrl,
    //       "fileName": "${DateTime.now().millisecondsSinceEpoch}-${imageUrl.split("/").last}"
    //     });
    //   } on PlatformException catch (e) {
    //     Exception("Failed to Invoke: '${e.message}'.");
    //   }
    // }else{
      try {

        final http.Response response = await http.get(Uri.parse(getImageLink(url: imageUrl)));


        final dir = Platform.isAndroid ? await getTemporaryDirectory() : await getApplicationSupportDirectory();

        var filePath = '${dir.path}/Wallpaper App';
        var fileName = '${DateTime.now().millisecondsSinceEpoch}.jpeg';

        File wallpaperPath = File("$filePath/$fileName");
        File androidPath = File("/storage/emulated/0/Pictures/$fileName");

        if (await Directory(filePath).exists()) {
          await wallpaperPath.writeAsBytes(response.bodyBytes);
        } else {
          await Directory(filePath).create(recursive: true);
          await wallpaperPath.writeAsBytes(response.bodyBytes);
        }

        /// TODO: uncomment this lines if image gallery added in pubspect
        // await ImageGallerySaver.saveImage(
        //   wallpaperPath.readAsBytesSync(),
        //     quality: 100,
        //     name: fileName,
        // );

        if(await SharedPreferenceService.getShowNotification){
          NotificationManager.showCompletedNotification(category: "Wallpaper",filePath: Platform.isAndroid ? androidPath.path : wallpaperPath.path);
        }

      } on PlatformException catch (e) {
        Exception(e);
        log("Error Downloading ==> $e");
      }
    // }
  }

  static int premiumCount = 0;

  static downloadImage(String imageUrl/*,{bool? showRewardAd}*/) async {
    showLoadingDialog();
    ///TODO: enable for downloads google ads
    // if(showRewardAd ?? false){

    // } else{
    //   AdHelper.createInterstitialAd(onDismissed: () async{
    //     Get.back();
    //
    //     bool photos = await Permission.photos.isGranted;
    //     bool storage = await Permission.storage.isGranted;
    //
    //     if (photos || storage) {
    //       await _downloadImage(imageUrl);
    //     } else {
    //       await Permission.photos.request();
    //       await Permission.storage.request();
    //       await _downloadImage(imageUrl);
    //     }
    //   },);
    // }
  }

  static _shareImage(String imageUrl) async{
    final http.Response response = await http.get(Uri.parse(getImageLink(url: imageUrl)));

    final dir = await getTemporaryDirectory();

    var filePath = dir.path;
    var fileName = "${DateTime.now().millisecondsSinceEpoch}.jpeg";

    File wallpaperPath = File("$filePath/$fileName");

    await wallpaperPath.writeAsBytes(response.bodyBytes);

    final result = await Share.shareXFiles([XFile(wallpaperPath.path)],text: AppConstants.shareAppTxt);

    log("filePath : ${wallpaperPath.path}");

    Get.back();
    if (result.status == ShareResultStatus.success) {
      debugPrint('Thank you for sharing the picture!');
    }
  }

  static shareImage(String imageUrl) async{
    showLoadingDialog();

  }


  static Future<void> setLiveWallpaper(String imageUrl) async {

    try {
      methodChannel.invokeMethod('downloadWallpaper', {
        "imageUrl": imageUrl,
        "fileName": "${DateTime.now().millisecondsSinceEpoch}-${imageUrl.split("/").last}"
      });
    } on PlatformException catch (e) {
      Exception("Failed to Invoke: '${e.message}'.");
    }
  }

}