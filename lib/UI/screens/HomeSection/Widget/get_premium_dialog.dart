import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reels_app/UI/common/blur_widget.dart';
import 'package:reels_app/UI/common/common_button.dart';
import 'package:reels_app/UI/common/headline_body_one_base_widget.dart';
import 'package:reels_app/infrastructure/constant/app_constant.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';
import 'package:reels_app/infrastructure/constant/font_constant.dart';
import 'package:reels_app/infrastructure/constant/image_constant.dart';

class GetPremiumDialogView extends StatelessWidget {
  GetPremiumDialogView({super.key,required this.onWatchAd,required this.subtitle,this.showAdButton = true});
  void Function() onWatchAd;
  String subtitle;
  bool showAdButton;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorConstants.transparent,
      child: Blur(
        blurColor: Colors.black,
        colorOpacity: .4,
        blur: 10,
        child: Column(
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
                      Image.asset(ImageConstant.updateAppImage),
                      /* Padding(
                        padding: const EdgeInsets.only(top: 14,left: 14,right: 14),
                        child: ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Colors.white,
                                Colors.white.withOpacity(.8),
                                // Colors.transparent.withOpacity(.2),
                                Colors.transparent.withOpacity(.2),
                                Colors.transparent,
                                Colors.transparent,
                              ],
                              stops: const [0.0,.4,0.6,0.9 ,1],
                            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstIn,
                          child: ImageConstant.imgUpdateApp,
                          // child: Image.asset(
                          //   ImageConstant.updateAppImage,
                          //   fit: BoxFit.cover,
                          //   alignment: Alignment.topCenter,
                          //   width: double.maxFinite,
                          // ),
                        ),
                      ),*/
                      const SizedBox(height: 24),

                      HeadlineBodyOneBaseWidget(
                        title: AppConstants.getPremiumNow.tr,
                        fontSize: 24,
                        titleColor: ColorConstants.white,
                        fontFamily: FontConstant.satoshiBold,
                        height: 1.25,
                        titleTextAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      HeadlineBodyOneBaseWidget(
                        title: subtitle,
                        fontSize: 14,
                        titleColor: ColorConstants.white.withOpacity(.7),
                        fontFamily: FontConstant.satoshiRegular,
                        height: 1.57,
                        titleTextAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      CommonButton(onTap: () {
                        Get.back();
                      }, title: AppConstants.upgradePremium.tr,bottomSpace: false,updateSpace: true),
                      if(showAdButton)
                      ...[const SizedBox(height: 8),
                      CommonButton(onTap: onWatchAd, title: AppConstants.watchAd.tr,backgroundColor: ColorConstants.transparent,titleColor: ColorConstants.white,bottomSpace: false,updateSpace: true),],
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
