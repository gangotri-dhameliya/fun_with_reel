import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reels_app/UI/common/common_background.dart';
import 'package:reels_app/UI/screens/SplashSection/splash_controller.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';
import 'package:reels_app/infrastructure/constant/image_constant.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: ColorConstants.background,
        body: CommonBackground(
          child: Center(
            child: SvgPicture.asset(
              ImageConstant.splashLogo,
              height: MediaQuery.sizeOf(context).height * .2,
            ),
          ),
        ),
      ),
    );
  }
}
