import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:reels_app/UI/common/common_background.dart';
import 'package:reels_app/UI/common/headline_body_one_base_widget.dart';
import 'package:reels_app/UI/screens/SettingSection/setting_controller.dart';
import 'package:reels_app/infrastructure/constant/app_constant.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';
import 'package:reels_app/infrastructure/constant/font_constant.dart';
import 'package:reels_app/infrastructure/constant/image_constant.dart';
import 'package:reels_app/infrastructure/constant/routes_constant.dart';
import 'package:reels_app/infrastructure/storage/shared_preference_service.dart';
import 'package:share_plus/share_plus.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
        init: SettingController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: ColorConstants.background,
            body: CommonBackground(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(ImageConstant.appIcon,height: 24,width: 24,),
                      HeadlineBodyOneBaseWidget(
                        title: AppConstants.setting.tr,
                        fontSize: 24,
                        titleColor: ColorConstants.white,
                        fontFamily: FontConstant.satoshiBold,
                      ).paddingSymmetric(horizontal: 8),
                    ],
                  ).paddingSymmetric(vertical: 22, horizontal: 20),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.productDetails.value = ProductDetails
                                  (id: "silver_plan",
                                    title: "Silver plan",
                                    description: "Reels app Plan",
                                    price:"\$1.99",
                                    rawPrice: 1.99,
                                    currencyCode: "");

                                controller.openInAppPurchasePopup(planId: "silver_plan");
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 36, horizontal: 16),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(color: ColorConstants.white.withOpacity(0.5),width: 1.5),

                                    borderRadius: BorderRadius.circular(24),
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [ColorConstants.yellow00, ColorConstants.orange05, ColorConstants.pink88],
                                        stops: [0.0, 0.4, 0.999])),
                                child: Column(
                                  children: [
                                    HeadlineBodyOneBaseWidget(
                                      title: AppConstants.getPremium.tr,
                                      fontSize: 40,
                                      fontFamily: FontConstant.satoshiBold,
                                      fontWeight: FontWeight.w700,
                                    ).marginOnly(bottom: 4),
                                    HeadlineBodyOneBaseWidget(
                                      title: AppConstants.premiumDesc.tr,
                                      fontSize: 14,
                                      titleTextAlign: TextAlign.center,
                                      fontFamily: FontConstant.satoshiRegular,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 24),
                                commonRowView(
                                  isSwitch: true,
                                  title: AppConstants.pushNotification.tr,
                                  onTap: () {
                                    controller.requestNotification();

                                  },
                                ),
                                SizedBox(height: 24),
                                commonRowView(
                                  title: AppConstants.shareApp.tr,
                                  onTap: () { Share.share(AppConstants.shareApp.tr);},
                                ),
                                SizedBox(height: 24),
                                commonRowView(
                                  title: AppConstants.rateUs.tr,
                                  onTap: () async {
                                    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
                                    //
                                    // OpenStore.instance.open(
                                    //   appStoreId: "284815942",
                                    //   androidAppBundleId: packageInfo.packageName,
                                    // );
                                  },
                                ),
                                SizedBox(height: 24),
                                commonRowView(
                                  title: AppConstants.termsCondition.tr,
                                  onTap: () async {
                                    Get.toNamed(RoutesConstant.termsAndConditionScreen);

                                  },
                                ),
                                SizedBox(height: 24),
                                commonRowView(
                                  title: AppConstants.privacyPolicy.tr,
                                  onTap: () async {
                                    Get.toNamed(RoutesConstant.privacyPolicyScreen);

                                  },
                                ),
                                SizedBox(height: 24),
                                commonRowView(
                                  title: AppConstants.yourStrike.tr,
                                  strikePoint: controller.strikePoint.value,
                                  isStrike: true,
                                  onTap: () async {
                                    // Get.toNamed(RoutesConstant.privacyPolicyScreen);

                                  },
                                ),
                                SizedBox(height: kBottomNavigationBarHeight+70,)

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  commonRowView({required GestureTapCallback onTap, required String title, bool isSwitch = false,bool isStrike = false, int strikePoint = 0}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: ColorConstants.white.withOpacity(0.4),width: 1),
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [ColorConstants.black.withOpacity(0.4), ColorConstants.black, ColorConstants.black],
                stops: [0.0, 0.4, 0.999])),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeadlineBodyOneBaseWidget(
              title: title,
              fontSize: 16,
              fontFamily: FontConstant.satoshiBold,
              fontWeight: FontWeight.w700,
            ),
            if(isStrike)
            HeadlineBodyOneBaseWidget(
              title: "${strikePoint}",
              fontSize: 16,
              fontFamily: FontConstant.satoshiBold,
              fontWeight: FontWeight.w700,
            ),
            if (isSwitch)
              Obx(
                () => Transform.scale(
                  scale: 0.8,
                  child: Container(
                    width: 36,
                    height: 20,
                    child: Switch.adaptive(
                      trackOutlineColor: MaterialStatePropertyAll(Colors.transparent),
                      trackColor: MaterialStatePropertyAll(ColorConstants.white),
                      thumbColor: MaterialStatePropertyAll(ColorConstants.black),
                      value: controller.showNotification.value,
                      onChanged: (value) {
                        controller.requestNotification();

                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
