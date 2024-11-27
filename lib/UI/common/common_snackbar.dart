import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reels_app/UI/common/common_loader.dart';
import 'package:reels_app/UI/common/custom_snackbar.dart';
import 'package:reels_app/UI/common/headline_body_one_base_widget.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';

showSnackbar({
  String? title,
  required String msg,
}) {
  showCustomSnackbar(
    "",
    "",
    backgroundColor: ColorConstants.black.withOpacity(0.4),
    margin: EdgeInsets.symmetric(vertical: 10,horizontal: Get.width * .1),
    animationDuration: const Duration(milliseconds: 500),
    // duration: const Duration(milliseconds: 1250),
    boxShadows: [
      BoxShadow(
        color: Colors.black.withOpacity(.5),
        blurRadius: 30,
        offset: const Offset(0,8),
      )
    ],
    messageText: Row(
      children: [
        const CommonLoader(),
        const SizedBox(width: 16),
        HeadlineBodyOneBaseWidget(
          title: msg,
          fontSize: 16,
          titleColor: Colors.white,
          maxLine: 2,
          titleTextAlign: TextAlign.center,
        ),
      ],
    ),
  );
  // Get.snackbar(
  //   title ?? "",
  //   msg,
  //   colorText: ColorConstants.white,
  //   snackPosition: SnackPosition.BOTTOM
  // );
}
