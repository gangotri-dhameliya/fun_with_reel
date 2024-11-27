import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reels_app/UI/common/common_background.dart';
import 'package:reels_app/UI/common/custom_appbar.dart';
import 'package:reels_app/UI/common/headline_body_one_base_widget.dart';
import 'package:reels_app/UI/screens/CategoriesSection/SubScreen/reel_detail_view.dart';
import 'package:reels_app/UI/screens/CategoriesSection/catregory_controller.dart';
import 'package:reels_app/UI/screens/CategoriesSection/widgets/category_card.dart';
import 'package:reels_app/infrastructure/constant/app_constant.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';
import 'package:reels_app/infrastructure/constant/font_constant.dart';
import 'package:reels_app/infrastructure/model/reels_data_model.dart';

class ViewAllScreen extends GetView<CategoryController> {
  const ViewAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: CommonBackground(
        topSpace: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            CustomAppBar(title: Get.arguments),
            Expanded(
                child: Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadlineBodyOneBaseWidget(
                      title: "${controller.reels.where((p0) => Get.arguments == p0.category).toList().length} ${AppConstants.videos.tr}",
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
                      itemCount: controller.reels.where((p0) => Get.arguments == p0.category).toList().length,
                      itemBuilder: (context, i) {
                        ReelDataModel reelsDataModel = controller.reels.where((p0) => Get.arguments == p0.category).toList()[i];
                        return GestureDetector(
                            onTap: () {
                              List<ReelDataModel> reelsData = [];
                              List<ReelDataModel> newReelData = [];

                              newReelData = controller.reels.where((p0) => Get.arguments == p0.category).toList();
                              newReelData.removeWhere((element) => element.isPremium == 'true');
                              newReelData.forEach((element) {
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
                            child: CategoryCard(reelsDataModel: reelsDataModel, noMargin: true));
                      },
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
