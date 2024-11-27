import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:reels_app/UI/screens/HomeSection/home_controller.dart';
import 'package:reels_app/UI/screens/SplashSection/splash_controller.dart';
import 'package:reels_app/infrastructure/constant/routes_constant.dart';
import 'package:reels_app/infrastructure/services/no_internet_dialog.dart';
import 'package:reels_app/infrastructure/storage/shared_preference_service.dart';

class InternetConnectionController extends GetxController {
  RxBool isInternetConnected = true.obs;
  RxBool showingDialog = false.obs;
  Rx<ConnectivityResult> connectionStatus = ConnectivityResult.none.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override
  void onInit() async{
    if (ConnectivityResult.none == await _connectivity.checkConnectivity()) {
      isInternetConnected.value = false;
    } else {
      isInternetConnected.value = true;
    }
    connectivitySubscription = _connectivity.onConnectivityChanged.listen((ConnectivityResult result) async{
      connectionStatus.value = result;
      if(connectionStatus.value == ConnectivityResult.none){
        isInternetConnected.value = false;
        // await Future.delayed(const Duration(milliseconds: 2500));
        if(!isInternetConnected.value){
          if(!showingDialog.value){
            log("Show Dialog");
            if(Platform.isIOS){
              log("Show Dialog IOS");
              if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
                // isInternetConnected.value = false;
                log("NO");

                showNoInternetDialog();
              } else {
                log("YES");
                // isInternetConnected.value = true;
              }
            }else{
              showNoInternetDialog();
            }
          }
        }
      }else{
        isInternetConnected.value = true;
        try{
          if(!(await SharedPreferenceService.getShowOnboardingScreen)){
            // Get.find<HomeController>().init();
          }
        }catch(e){
          Exception(e);
        }
      }
    });
    super.onInit();
  }

  showNoInternetDialog() {
    showingDialog.value = true;
    update();
    Get.dialog(
      NoInternetDialog(
        onRetryTap: () {
          if (isInternetConnected.value) {
            if(Get.currentRoute == RoutesConstant.splashScreen){
              Get.find<SplashController>().getReelsData();
              Get.find<SplashController>().getVersion();
            }
            Get.find<HomeController>().init();
            // Get.find<SearchScreenController>().getCarouselData();
            Get.back();
            showingDialog.value = false;
          } else {
            // Get.back();
            // showNoInternetDialog();
            showingDialog.value = false;
          }
        },
      ),
      barrierDismissible: false,
      useSafeArea: false,
    );
  }
}