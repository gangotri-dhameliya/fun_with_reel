import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:reels_app/UI/screens/SplashSection/widgets/update_app_dialog.dart';
import 'package:reels_app/infrastructure/constant/api_constant.dart';
import 'package:reels_app/infrastructure/constant/routes_constant.dart';
import 'package:reels_app/infrastructure/model/reels_data_model.dart';
import 'package:reels_app/infrastructure/package/open_store.dart';
import 'package:reels_app/infrastructure/services/api_service.dart';
import 'package:reels_app/infrastructure/services/google_sheet_service.dart';
import 'package:reels_app/infrastructure/storage/shared_preference_service.dart';
import 'package:reels_app/infrastructure/utils/utils.dart';

class SplashController extends GetxController {

  @override
  void onInit() async {
    super.onInit();
    getVersion();
    getReelsData();
  }

  RxString versionCode = "".obs;

  getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // try{
      Worksheet? productSheet = await GoogleSheetService.initReels(workSheetId: ApiConstant.versionCodeId);
      final values = (await productSheet!.values.allRows())
          .skip(1)
          .toList();
      for (var data in values) {
        versionCode.value = Platform.isAndroid ?  data[0] : data[1];
      }
    // } catch(e){
    //   Exception(e);
    // }

      await Future.delayed(const Duration(milliseconds: 1000));
      bool onboardingValue =
      await SharedPreferenceService.getShowOnboardingScreen;
      // _connectivitySubscription.cancel();
      Get.offAllNamed(/*onboardingValue
          ? RoutesConstant.onboardingScreen
          :*/ RoutesConstant.mainScreen);
      if(versionCode.value != ""){
        if (versionCode.value != packageInfo.version) {
          showUpdateDialog(packageInfo.packageName, "284815942");
        }
      }
  }

  getReelsData() async{
    String date = await SharedPreferenceService.getDate;
    DateTime now = DateTime.now();
    String todayDate = getDate(now);
    await ApiService.getReels(workSheetId: 0).then((value) async {
      await SharedPreferenceService.saveReels(ReelDataModel.encode(value));
    });
    await ApiService.getCategories().then((value) async {
      await SharedPreferenceService.saveReelsCategories(jsonEncode(value));
    });
    if(date != todayDate){
      await SharedPreferenceService.saveDate(getDate(now));

      await SharedPreferenceService.savePremiumWallpaperLimit(0.toString());
    }
  }

  void showUpdateDialog(
      String androidApplicationId,
      String iOSAppId, {
        String message = "You can now update this app from store.",
        String titleText = 'Update Available',
        String dismissText = 'Later',
        String updateText = 'Update Now',
      }) async {
    updateAction() {
      launchAppStore(androidApplicationId, iOSAppId);
    }
    Get.dialog(
      UpdateAppDialogView(onUpdateTap: updateAction),
      useSafeArea: false,
      barrierDismissible: false
    );
  }

  void launchAppStore(String androidApplicationId, String iOSAppId) async {
    OpenStore.instance.open(
      appStoreId: iOSAppId,
      androidAppBundleId: androidApplicationId,
    );
  }
}
