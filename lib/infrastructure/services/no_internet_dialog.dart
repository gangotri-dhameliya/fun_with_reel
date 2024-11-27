import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reels_app/UI/common/blur_widget.dart';
import 'package:reels_app/UI/common/common_button.dart';
import 'package:reels_app/UI/common/headline_body_one_base_widget.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';
import 'package:reels_app/infrastructure/constant/font_constant.dart';
import 'package:reels_app/infrastructure/constant/image_constant.dart';

class NoInternetDialog extends StatelessWidget {
  const NoInternetDialog({super.key, required this.onRetryTap});

  final GestureTapCallback onRetryTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorConstants.transparent,
      child: Blur(
        blurColor: Colors.black,
        colorOpacity: .4,
        blur: 10,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Blur(
                blurColor: Colors.black,
                colorOpacity: .4,
                blur: 10,
                borderRadius: BorderRadius.circular(36),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorConstants.black.withOpacity(.2),
                    border: Border.all(color: ColorConstants.white.withOpacity(.25)),
                    borderRadius: BorderRadius.circular(36),
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(ImageConstant.noInternetIcon,height: 100,width: 100,),
                      const SizedBox(height: 16),
                      const HeadlineBodyOneBaseWidget(
                        title: "Internet Connection Lost!",
                        fontSize: 24,
                        titleColor: ColorConstants.white,
                        fontFamily: FontConstant.satoshiBold,
                        height: 1.25,
                        titleTextAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      HeadlineBodyOneBaseWidget(
                        title: "Please check your internet connection.",
                        fontSize: 14,
                        titleColor: ColorConstants.white.withOpacity(.7),
                        fontFamily: FontConstant.satoshiRegular,
                        height: 1.57,
                        titleTextAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      CommonButton(
                        onTap: onRetryTap,
                        title: "Retry",
                        bottomSpace: false,
                        updateSpace: true,
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
  }
}
