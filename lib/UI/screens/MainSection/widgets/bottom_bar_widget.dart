import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reels_app/UI/common/blur_widget.dart';
import 'package:reels_app/UI/screens/MainSection/main_screen_controller.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';
import 'package:reels_app/infrastructure/constant/image_constant.dart';
GlobalKey bottomKey = GlobalKey();

class BottomBarWidget extends StatefulWidget {
  BottomBarWidget({
    super.key,
    required this.active,
    required this.homeTap,
    required this.premiumTap,
    required this.categoryTap,
    required this.likeTap,
    required this.settingTap,
  });

  final GestureTapCallback homeTap;
  final GestureTapCallback premiumTap;
  final GestureTapCallback categoryTap;
  final GestureTapCallback likeTap;
  final GestureTapCallback settingTap;
  final int active;

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  bool isFirst = true;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Get.find<MainScreenController>().showMoreMenu.value ? Alignment.bottomCenter : Alignment(0.68,1),
      child: AnimatedBuilder(
        animation: Get.find<MainScreenController>().animationController,
        builder: (context, child) {
          return Container(
            height: 66,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 34),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                color: ColorConstants.transparent
            ),
            padding: const EdgeInsets.all(2),
            child: Transform.translate(
              offset: Offset(Tween<double>(begin: 20, end: 0).animate(Get.find<MainScreenController>().animationController).value, 0),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(50),
                  bottom: Radius.circular(50),
                ),
                child: Blur(
                  blurColor: Colors.black,
                  colorOpacity:  Get.find<MainScreenController>().showMoreMenu.value ? .4 : 1,
                  borderRadius: BorderRadius.circular(100),
                  blur: 10,
                  child: IntrinsicWidth(
                    child: Stack(
                      children: [
                        if(Get.find<MainScreenController>().showMoreMenu.value)
                        AnimatedPadding(
                          duration: const Duration(milliseconds: 150),
                          padding: EdgeInsets.only(
                              left: widget.active == 0
                                  ? 0
                                  : widget.active == 1
                                  ? 59
                                  : widget.active == 2
                                  ? 119
                                  : widget.active == 3 ? 179 : 239),
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            alignment: Alignment.center,
                            height: 58,
                            width: 58,
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(300),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          height: 62,
                          duration: Duration(seconds: 5),
                          key: bottomKey,
                          padding: const EdgeInsets.all(2),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if(Get.find<MainScreenController>().showMoreMenu.value)
                              ...[
                                bottomIcons(
                                  onTap: widget.homeTap,
                                  icon: ImageConstant.homeIcon,
                                  index: 0,
                                ),
                                bottomIcons(
                                  onTap: widget.premiumTap,
                                  icon: ImageConstant.premiumIcon,
                                  index: 1,
                                ),
                                bottomIcons(
                                  onTap: widget.categoryTap,
                                  icon: ImageConstant.categoryIcon,
                                  index: 2,
                                ),
                                bottomIcons(
                                  onTap: widget.settingTap,
                                  icon: ImageConstant.settingsIcon,
                                  index: 3,
                                ),
                              ],

                              // bottomIcons(
                              //   onTap: likeTap,
                              //   icon: ImageConstant.noFillLikeIcon,
                              //   index: 3,
                              // ),

                              bottomIcons(
                                onTap: () {
                                  if(Get.find<MainScreenController>().showMoreMenu.value){
                                    Get.find<MainScreenController>().animationController.reverse(); // Start animation from beginning

                                    Get.find<MainScreenController>().showMoreMenu.value =false;
                                    Get.find<MainScreenController>().update();
                                  }else{
                                    Get.find<MainScreenController>().animationController.forward(); // Reverse animation if already completed
                                    Get.find<MainScreenController>().showMoreMenu.value =true;
                                    Get.find<MainScreenController>().update();
                                  }

                                },
                                icon: Get.find<MainScreenController>().showMoreMenu.value ? ImageConstant.closeIcon : ImageConstant.moreIcon,
                                index: 4,
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     log("On menu icon tap");
                              //     Get.find<MainScreenController>().showMoreMenu.value =false;
                              //     Get.find<MainScreenController>().update();
                              //   },
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //         color: ColorConstants.black.withOpacity(0.2),
                              //         borderRadius: BorderRadius.circular(16)
                              //     ),
                              //     constraints: BoxConstraints(maxHeight: 48,maxWidth: 48),
                              //
                              //     padding: EdgeInsets.all(4),
                              //     child: SvgPicture.asset(ImageConstant.moreIcon),
                              //   )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget bottomIcons({
    required GestureTapCallback onTap,
    required String icon,
    required int index,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: AnimatedContainer(
        padding: const EdgeInsets.all(18),
        curve: Curves.bounceInOut,
        alignment: Alignment.center,
        height: 62,
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
        ),
        child: SvgPicture.asset(
          icon,
          width: index == 4 ? 20 :24,
          height: index == 4 ? 20 : 24,
          colorFilter: ColorFilter.mode(
              widget.active == index ? ColorConstants.black : ColorConstants.white,
              BlendMode.srcIn),
        ),
      ),
    );
  }
}

// child: Container(
//   width: width,
//   height: height * (Platform.isIOS ? .15 : .1),
//   decoration: const BoxDecoration(
//     color: ColorConstants.transparent,
//     borderRadius: BorderRadius.only(
//       topLeft: Radius.circular(30),
//       topRight: Radius.circular(30),
//     ),
//   ),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
//       InkWell(
//         onTap: homeTap,
//         child: Container(
//           alignment: Alignment.center,
//           height: 60,
//           width: width / 5,
//           child: SvgPicture.asset(
//             ImageConstant.homeIcon,
//             width: 24.0,
//             height: 24.0,
//             colorFilter: ColorFilter.mode(
//                 active == 0 ? ColorConstants.blue : ColorConstants.white,
//                 BlendMode.srcIn),
//           ),
//         ),
//       ),
//       InkWell(
//         onTap: searchTap,
//         child: Container(
//           alignment: Alignment.center,
//           height: 60,
//           width: width / 5,
//           child: SvgPicture.asset(
//             ImageConstant.searchIcon,
//             width: 24.0,
//             height: 24.0,
//             colorFilter: ColorFilter.mode(
//                 active == 1 ? ColorConstants.blue : ColorConstants.white,
//                 BlendMode.srcIn),
//           ),
//         ),
//       ),
//       InkWell(
//         onTap: categoryTap,
//         child: Container(
//           alignment: Alignment.center,
//           height: 60,
//           width: width / 5,
//           child: SvgPicture.asset(
//             ImageConstant.categoryIcon,
//             width: 24.0,
//             height: 24.0,
//             colorFilter: ColorFilter.mode(
//                 active == 2 ? ColorConstants.blue : ColorConstants.white,
//                 BlendMode.srcIn),
//           ),
//         ),
//       ),
//       InkWell(
//         onTap: settingTap,
//         child: Container(
//           alignment: Alignment.center,
//           height: 60,
//           width: width / 5,
//           child: SvgPicture.asset(
//             ImageConstant.settingsIcon,
//             width: 24.0,
//             height: 24.0,
//             colorFilter: ColorFilter.mode(
//                 active == 3 ? ColorConstants.blue : ColorConstants.white,
//                 BlendMode.srcIn),
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
