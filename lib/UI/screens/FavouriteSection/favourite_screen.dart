import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reels_app/UI/common/common_background.dart';
import 'package:reels_app/UI/common/custom_appbar.dart';
import 'package:reels_app/UI/common/headline_body_one_base_widget.dart';
import 'package:reels_app/UI/screens/CategoriesSection/widgets/category_card.dart';
import 'package:reels_app/UI/screens/FavouriteSection/SubScreen/favouriteReel_page.dart';
import 'package:reels_app/UI/screens/FavouriteSection/favourite_controller.dart';
import 'package:reels_app/infrastructure/constant/app_constant.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';
import 'package:reels_app/infrastructure/constant/font_constant.dart';
import 'package:reels_app/infrastructure/model/reels_data_model.dart';

class FavouriteScreen extends GetView<FavouriteController> {
  const FavouriteScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouriteController>(
        init: FavouriteController(),
        builder: (controller) {
          // controller.getAllReelsData();
          return Scaffold(
            backgroundColor: ColorConstants.background,
            body: CommonBackground(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  CustomAppBar(title: AppConstants.favorite.tr,),
                  HeadlineBodyOneBaseWidget(
                    title: AppConstants.favorite.tr,
                    fontSize: 24,
                    titleColor: ColorConstants.white,
                    fontFamily: FontConstant.satoshiBold,
                  ).paddingSymmetric(vertical: 22, horizontal: 20),
                  Expanded(
                    child: controller.reels.isEmpty
                        ? Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height * 0.12),
                        child: HeadlineBodyOneBaseWidget(
                          title: AppConstants.noFavouriteData.tr,
                          fontWeight: FontWeight.w500,
                          fontFamily: FontConstant.satoshiRegular,
                          fontSize: 16,
                        ))
                        : Container(
                          margin: EdgeInsets.symmetric(horizontal: 24),
                          padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height * 0.13),
                          child: SingleChildScrollView(
                            controller: controller.scrollController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeadlineBodyOneBaseWidget(
                                  title: "${controller.reels.length} ${AppConstants.videos.tr}",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  fontFamily: FontConstant.satoshiRegular,
                                ).marginSymmetric(vertical: 12),
                                GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, childAspectRatio: 1 / 1.5, crossAxisSpacing: 12, mainAxisSpacing: 12),
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: controller.reels.length,
                                  itemBuilder: (context, i) {
                                    ReelDataModel reelsDataModel = controller.reels.toList()[i];
                                    return GestureDetector(
                                        onTap: () {
                                          List<ReelDataModel> reelsData = [];
                                          controller.reels.forEach((element) {
                                            if (element.reelsId == reelsDataModel.reelsId) {
                                              reelsData.insert(0, element);
                                            } else {
                                              reelsData.add(element);
                                            }
                                          });
                                          controller.update();
                                          Get.to(()=> FavouriteReelsVideoPage(reels: reelsData,showBackButton: true,cardIndex: i,));
                                        },
                                        child: CategoryCard(reelsDataModel: reelsDataModel, noMargin: true));
                                  },
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
}
