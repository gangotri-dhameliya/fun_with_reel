import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reels_app/UI/common/common_background.dart';
import 'package:reels_app/UI/common/common_loader.dart';
import 'package:reels_app/UI/common/headline_body_one_base_widget.dart';
import 'package:reels_app/UI/screens/CategoriesSection/SubScreen/reel_detail_view.dart';
import 'package:reels_app/UI/screens/CategoriesSection/catregory_controller.dart';
import 'package:reels_app/UI/screens/CategoriesSection/widgets/category_card.dart';
import 'package:reels_app/UI/screens/HomeSection/Widget/get_premium_dialog.dart';
import 'package:reels_app/infrastructure/AdHelper/ad_helper.dart';
import 'package:reels_app/infrastructure/constant/app_constant.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';
import 'package:reels_app/infrastructure/constant/font_constant.dart';
import 'package:reels_app/infrastructure/constant/image_constant.dart';
import 'package:reels_app/infrastructure/constant/routes_constant.dart';
import 'package:reels_app/infrastructure/model/reels_data_model.dart';

class CategoriesScreen extends GetView<CategoryController> {
  const CategoriesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
        init: CategoryController(),
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
                        title: AppConstants.category.tr,
                        fontSize: 24,
                        titleColor: ColorConstants.white,
                        fontFamily: FontConstant.satoshiBold,
                      ).paddingSymmetric(horizontal: 8),
                    ],
                  ).paddingSymmetric(vertical: 22, horizontal: 20),
                  Expanded(child:
                  controller.isCategoryPlaying.value
                      ? Container(padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height * 0.12), child: const CommonLoader())
                      : !controller.isCategoryPlaying.value && controller.allCategory.isEmpty
                      ? Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height * 0.12),
                      child: HeadlineBodyOneBaseWidget(
                        title: AppConstants.noCategoriesData.tr,
                        fontWeight: FontWeight.w500,
                        fontFamily: FontConstant.satoshiRegular,
                        fontSize: 16,
                      ))
                      : ListView.builder(
                    itemCount: controller.allCategory.length,
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.sizeOf(context).height * 0.12,
                    ),
                    itemBuilder: (context, index) {
                      return controller.favouriteReels.isNotEmpty && index== 0 ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Row(

                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HeadlineBodyOneBaseWidget(
                              title: AppConstants.favorite.tr,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: FontConstant.satoshiBold,
                            ),
                            if(controller.favouriteReels.length >= 3)
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(RoutesConstant.favouriteScreen);
                              },
                              child: HeadlineBodyOneBaseWidget(
                                title: AppConstants.viewAll.tr,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: FontConstant.satoshiRegular,
                              ),
                            )
                          ],
                        ).marginSymmetric(horizontal: 24, vertical: 24),
                          Container(
                            height: 244,
                            child: ListView.builder(
                              padding: EdgeInsets.only(left: 8),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: controller.favouriteReels.length >= 3
                                  ? 3
                                  : controller.favouriteReels.length,
                              itemBuilder: (context, i) {
                                ReelDataModel reelsDataModel =
                                controller.favouriteReels[i];
                                return GestureDetector(
                                    onTap:  () {
                                      List<ReelDataModel> reelsData = [];
                                      List<ReelDataModel> newReelData = [];
                                      newReelData= controller.favouriteReels;
                                      newReelData
                                          .forEach((element) {
                                        if (element.reelsId == reelsDataModel.reelsId) {
                                          reelsData.insert(0, element);
                                        } else {
                                          reelsData.add(element);
                                        }
                                      });
                                      controller.update();
                                      if (reelsData.isNotEmpty) {
                                        Get.to(ReelDetailScreen(reels: reelsData, showBackButton: true));
                                      }
                                    },
                                    child: CategoryCard(reelsDataModel: reelsDataModel));
                              },
                            ),
                          ),
                        ],
                      )
                          :Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (controller.reels.where((p0) => controller.allCategory[index] == p0.category).toList().isNotEmpty)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                HeadlineBodyOneBaseWidget(
                                  title: controller.allCategory[index],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: FontConstant.satoshiBold,
                                ),
                                if(controller.reels.where((p0) => controller.allCategory[index] == p0.category).toList().length >= 3)
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(RoutesConstant.viewAllScreen, arguments: controller.allCategory[index]);
                                  },
                                  child: HeadlineBodyOneBaseWidget(
                                    title: AppConstants.viewAll.tr,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: FontConstant.satoshiRegular,
                                  ),
                                )
                              ],
                            ).marginSymmetric(horizontal: 24, vertical: 24),
                          Container(
                            height: 244,
                            child: ListView.builder(
                              padding: EdgeInsets.only(left: 8),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: controller.reels.where((p0) => controller.allCategory[index] == p0.category).toList().length >= 3
                                  ? 3
                                  : controller.reels.where((p0) => controller.allCategory[index] == p0.category).toList().length,
                              itemBuilder: (context, i) {
                                ReelDataModel reelsDataModel =
                                controller.reels.where((p0) => controller.allCategory[index] == p0.category).toList()[i];
                                return GestureDetector(
                                    onTap: reelsDataModel.isPremium == "false" ?  () {
                                      List<ReelDataModel> reelsData = [];
                                      List<ReelDataModel> newReelData = [];
                                      newReelData= controller.reels .where((p0) => controller.allCategory[index] == p0.category)
                                          .toList();
                                      newReelData.removeWhere((element) => element.isPremium=='true');
                                      newReelData
                                          .forEach((element) {
                                        if (element.reelsId == reelsDataModel.reelsId) {
                                          reelsData.insert(0, element);
                                        } else {
                                          reelsData.add(element);
                                        }
                                      });
                                      controller.update();
                                      if (reelsData.isNotEmpty) {
                                        Get.to(ReelDetailScreen(reels: reelsData, showBackButton: true));
                                      }
                                    } : (){
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
                                      );
                                    },
                                    child: CategoryCard(reelsDataModel: reelsDataModel));
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ))
                ],
              ),
            ),
          );
        });
  }
}
