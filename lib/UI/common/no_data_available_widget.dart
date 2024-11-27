import 'package:flutter/material.dart';
import 'package:reels_app/UI/common/headline_body_one_base_widget.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';
import 'package:reels_app/infrastructure/constant/font_constant.dart';
import 'package:reels_app/infrastructure/constant/image_constant.dart';

class NoDataAvailableWidget extends StatelessWidget {
  const NoDataAvailableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Image.asset(ImageConstant.noDataFoundImg),
          ),
          const SizedBox(height: 20),
          HeadlineBodyOneBaseWidget(
            title: "No data found",
            titleColor: ColorConstants.white.withOpacity(.8),
            fontFamily: FontConstant.satoshiBold,
            fontSize: 17,
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
