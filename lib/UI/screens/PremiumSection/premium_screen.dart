import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reels_app/UI/common/common_background.dart';
import 'package:reels_app/UI/common/common_loader.dart';
import 'package:reels_app/UI/common/headline_body_one_base_widget.dart';
import 'package:reels_app/UI/screens/CategoriesSection/SubScreen/reel_detail_view.dart';
import 'package:reels_app/UI/screens/CategoriesSection/widgets/category_card.dart';
import 'package:reels_app/UI/screens/PremiumSection/premium_controller.dart';
import 'package:reels_app/infrastructure/AdHelper/ad_helper.dart';
import 'package:reels_app/infrastructure/constant/app_constant.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';
import 'package:reels_app/infrastructure/constant/font_constant.dart';
import 'package:reels_app/infrastructure/constant/image_constant.dart';
import 'package:reels_app/infrastructure/model/reels_data_model.dart';

import '../HomeSection/Widget/get_premium_dialog.dart';

class PremiumScreen extends GetView<PremiumController> {
  const PremiumScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PremiumController>(
        init: PremiumController(),
        builder: (controller) {
          print("reellsss:: ${controller.reels.map((element) => element.reelsId)}");
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
                        title: AppConstants.premiumTitle.tr,
                        fontSize: 24,
                        titleColor: ColorConstants.white,
                        fontFamily: FontConstant.satoshiBold,
                      ).paddingSymmetric(horizontal: 8),
                    ],
                  ).paddingSymmetric(vertical: 22, horizontal: 20),
                  Expanded(
                    child: controller.isLoading.value
                        ? Container(padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height * 0.12), child: const CommonLoader())
                        : !controller.isLoading.value && controller.reels.isEmpty
                            ? Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height * 0.12),
                                child: HeadlineBodyOneBaseWidget(
                                  title: AppConstants.noReelsData.tr,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: FontConstant.satoshiRegular,
                                  fontSize: 16,
                                ))
                            : GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 1 / 1.5, crossAxisSpacing: 12, mainAxisSpacing: 12),
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: controller.reels.where((p0) => p0.isPremium == 'true').length,
                                itemBuilder: (context, i) {
                                  ReelDataModel reelsDataModel = controller.reels.where((p0) => p0.isPremium == 'true').toList()[i];
                                  return GestureDetector(
                                      onTap: true ? () {
                                        Get.dialog(
                                            GetPremiumDialogView(
                                              subtitle: AppConstants.upgradeToPremiumShow.tr,
                                              showAdButton: false,
                                              onWatchAd: () {
                                                AdHelper.createRewardedAd(
                                                  onDismissed: () {
                                                    Get.back();
                                                  },
                                                  onUserEarnedReward: () {}
                                                );
                                              },),
                                            useSafeArea: false,
                                            barrierDismissible: true
                                        );
                                      } : (){},
                                      child: CategoryCard(reelsDataModel: reelsDataModel, noMargin: true));
                                },
                              ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
