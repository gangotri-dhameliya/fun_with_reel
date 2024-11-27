import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reels_app/UI/common/headline_body_one_base_widget.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';
import 'package:reels_app/infrastructure/constant/font_constant.dart';


showLoadingDialog(){
  Get.dialog(const CommonLoadingDialog());
}


class CommonLoadingDialog extends StatelessWidget {
  const CommonLoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      backgroundColor: ColorConstants.background,
      content: SizedBox(
        height: 40,
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              SizedBox(width: 16),
              HeadlineBodyOneBaseWidget(
                title: "Please wait",
                titleColor: ColorConstants.white,
                fontSize: 18,
                fontFamily: FontConstant.satoshiMedium,
              ),
            ],
          ),
        ),
      ),
      contentPadding: EdgeInsets.all(16),
    );
  }
}
