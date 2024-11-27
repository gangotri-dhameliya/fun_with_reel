import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:reels_app/UI/screens/MainSection/main_screen_controller.dart';
import 'package:reels_app/infrastructure/storage/shared_preference_service.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';


class SettingController extends GetxController {
  RxBool showNotification = false.obs;
  RxInt  strikePoint = 0.obs;

  requestNotification() async{
    showNotification.value = !showNotification.value;
    await SharedPreferenceService.saveShowNotification(showNotification.value);
  }

  @override
  void onInit() async{
    showNotification.value = await SharedPreferenceService.getShowNotification;
    strikePoint.value = await SharedPreferenceService.getUserStreakPoint;
    update();
    log("Strike point value ===> ${strikePoint}");
    await SharedPreferenceService.saveShowNotification(showNotification.value);
    super.onInit();
  }

Rx<ProductDetails> productDetails = ProductDetails(id: "", title: "", description: "", price: "", rawPrice: 0.0, currencyCode: "").obs;
void openInAppPurchasePopup({required String planId}) {
  late PurchaseParam purchaseParam;
  if (Platform.isAndroid) {


    purchaseParam = GooglePlayPurchaseParam(
      productDetails: productDetails.value,
      applicationUserName: null,
/*changeSubscriptionParam: (oldSubscription != null)
                ? ChangeSubscriptionParam(
              oldPurchaseDetails: oldSubscription,
              prorationMode: ProrationMode.immediateWithTimeProration,
            )
                : null*/);
  } else {
    purchaseParam = PurchaseParam(
      productDetails: productDetails.value,
      applicationUserName: null,
    );
  }

  Get.find<MainScreenController>().inAppPurchase.buyNonConsumable(
      purchaseParam: purchaseParam).then((value) {
    log("value35give::: $value");
// final result =value;
// CommonAPis.createInAppPurchase();
  });
}

}
