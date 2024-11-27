import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reels_app/UI/common/headline_body_one_base_widget.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';
import 'package:reels_app/infrastructure/constant/font_constant.dart';
import 'package:reels_app/infrastructure/constant/image_constant.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title, this.onBackTap});

  final String title;
  final GestureTapCallback? onBackTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 22),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onBackTap ?? () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(100),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorConstants.white.withOpacity(.1),
                border: Border.all(color: ColorConstants.white.withOpacity(.25)),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                ImageConstant.backIcon,
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                    ColorConstants.white, BlendMode.srcIn),
              ),
            ),
          ),
          const SizedBox(width: 12),
          HeadlineBodyOneBaseWidget(
            title: title,
            fontSize: 24,
            titleColor: ColorConstants.white,
            height: 1.3,
            fontFamily: FontConstant.satoshiBold,
          ),
        ],
      ),
    );
  }
}
