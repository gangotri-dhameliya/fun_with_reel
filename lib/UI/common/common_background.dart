import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reels_app/UI/common/headline_body_one_base_widget.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';
import 'package:reels_app/infrastructure/constant/font_constant.dart';
import 'package:reels_app/infrastructure/constant/image_constant.dart';
import 'package:reels_app/infrastructure/services/no_internet_controller.dart';

class CommonBackground extends StatelessWidget {
  CommonBackground({super.key, required this.child, this.topSpace});

  final Widget child;
  final bool? topSpace;

  final internetController = Get.find<InternetConnectionController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.only(top: topSpace ?? true ? 40 : 0),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(ImageConstant.backgroundImg), fit: BoxFit.fill),
      ),
      child: Obx(
        () => internetController.isInternetConnected.value
            ? child
            : const Center(
                child: HeadlineBodyOneBaseWidget(
                  title: "No Internet Connection!",
                  titleColor: ColorConstants.white,
                  fontSize: 24,
                  fontFamily: FontConstant.satoshiBold,
                ),
              ),
      ),
    );
  }
}
