import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:reels_app/infrastructure/constant/toast.dart';
import 'package:reels_app/infrastructure/storage/shared_preference_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreenController extends GetxController with GetSingleTickerProviderStateMixin{
  RxInt selectedIndex = 0.obs;

  final pageController = PageController();
  final InAppPurchase inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> subscription;
  List<PurchaseDetails> purchaseDetails = [];
  List<ProductDetails> products = [];
  RxMap<String, PurchaseDetails> purchases = <String, PurchaseDetails>{}.obs;
  RxList purchaseList = [""].obs;
  RxBool canExit = false.obs;
  RxBool showMoreMenu = false.obs;
  ContainerTransitionType transitionType = ContainerTransitionType.fade;
  late final animationController =
  AnimationController(vsync: this, duration: Duration(milliseconds: 100))
    ..addListener(() {
      update();
    });

  late final animation = Tween<double>(begin: 100, end: 0).animate(animationController);

  animateToPage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 1),
      curve: Curves.easeIn,
    );
  }

  void selectIndex(int index) => selectedIndex.value = index;

  @override
  void onInit() async{
    super.onInit();
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        inAppPurchase.purchaseStream;
    subscription = purchaseUpdated.listen((purchaseDetailsList) {listenToPurchaseUpdated(purchaseDetailsList);}, onDone: () {
      subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    
    log("user purchase detailllll=====> ${purchaseUpdated.first.then((value){
      log("value os printed ===> ${value.first}");
    }
    )}");
  }

  Future<void>  initStoreInfo(List<String> productId) async {
    final bool isAvailable = await inAppPurchase.isAvailable();
    if (!isAvailable) {
      products = [];
      update();
      return;
    }
    purchases.value = Map.fromEntries(
        purchaseDetails.map((PurchaseDetails purchase) {
          if (purchase.pendingCompletePurchase) {
            inAppPurchase.completePurchase(purchase);
          }
          return MapEntry<String, PurchaseDetails>(
              purchase.productID, purchase);
        }));
    if (Platform.isIOS) {
      var iosPlatformAddition = inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());

    }

    ProductDetailsResponse productDetailResponse =
    await inAppPurchase.queryProductDetails(productId.toSet());
    // log("Android product detail ===> ${productDetailResponse.error}");
    // log("Android product detail ===> ${productId.toSet()}");
    // log("Android product detail ===> ${productDetailResponse.productDetails}");
    // log("Android product detail ===> ${productDetailResponse.notFoundIDs}");
    if (productDetailResponse.error != null) {
      products = productDetailResponse.productDetails;
      update();
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      products = productDetailResponse.productDetails;
      update();
      return;
    }

    products = productDetailResponse.productDetails;

    purchaseList.value = productDetailResponse.productDetails.map((
        e) => e.id).toList();
    List<String> purchaseCurrencySymbolList = productDetailResponse.productDetails.map((
        e) => e.currencySymbol).toList();

    // currencyPriceSymbol.value = purchaseCurrencySymbolList.first;
    update();
  }

  Future<void> listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {


    List<PurchaseDetails> purchaseList = <PurchaseDetails>[];
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        await inAppPurchase.completePurchase(purchaseDetails);

        showTopToast(msg: "Payment Pending");
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {

          showTopToast(msg: "Payment Pending");
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          purchaseList.add(purchaseDetails);

        }
        if (purchaseDetails.pendingCompletePurchase) {
          await inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }

    deliverProduct(purchaseList);
  }

  deliverProduct(List<PurchaseDetails> purchaseDetails) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (purchaseDetails.isNotEmpty) {
      purchaseDetails.addAll(purchaseDetails);
      List<String> planList = <String>[].obs;

      if (purchaseDetails.isNotEmpty) {
        for (var element in purchaseDetails) {
          if (element.status == PurchaseStatus.purchased ||
              element.status == PurchaseStatus.restored) {
            if (element.productID == "Silver_plan") {

              SharedPreferenceService.saveBoolValue("silver", true);
              if (element.status == PurchaseStatus.restored) {
                planList.add("Silver Plan");
              }
            } else if (element.productID == "Gold_plan") {
              SharedPreferenceService.saveBoolValue("gold", true);
              if (element.status == PurchaseStatus.restored) {
                planList.add("Gold Plan");
              }
            } else if (element.productID == "Vip_plan") {
              SharedPreferenceService.saveBoolValue("Vip_plan", true);
              if (element.status == PurchaseStatus.restored) {
                planList.add("VIP Plan");
              }
            }
          }
        }

        // bool purchased = getAllStatusRestored(purchaseDetails);
        //
        // if (purchased) {
        //   showPurchaseDialog(
        //       context: Get.context!,
        //       planList: purchaseDetails
        //           .expand((e) =>
        //       [if (e.status == PurchaseStatus.restored) e.productID])
        //           .toList());
        // }


      }
    }
  }

  static bool getAllStatusRestored(List<PurchaseDetails> purchaseDetails) {
    bool status = true;

    for (var element in purchaseDetails) {
      if (element.status == PurchaseStatus.purchased) {
        status = false;
      }
    }

    return status;
  }
}

class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}


