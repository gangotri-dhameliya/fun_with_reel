import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:reels_app/UI/screens/CategoriesSection/categories_screen.dart';
import 'package:reels_app/UI/screens/FavouriteSection/favourite_screen.dart';
import 'package:reels_app/UI/screens/HomeSection/home_screen.dart';
import 'package:reels_app/UI/screens/MainSection/main_screen_controller.dart';
import 'package:reels_app/UI/screens/MainSection/widgets/bottom_bar_widget.dart';
import 'package:reels_app/UI/screens/PremiumSection/premium_screen.dart';
import 'package:reels_app/UI/screens/SettingSection/setting_screen.dart';
import 'package:reels_app/infrastructure/constant/app_constant.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';
import 'package:reels_app/infrastructure/constant/image_constant.dart';
import 'package:reels_app/infrastructure/constant/toast.dart';

class MainScreen extends GetView<MainScreenController> {
  MainScreen({super.key});
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MainScreenController(),
      builder: (controller) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: PopScope(
            canPop: controller.canExit.value,
            onPopInvoked: (didPop) async {
              if(!controller.canExit.value) {
                showTopToast(msg: AppConstants.tapToExit.tr,duration: 2);
                controller.canExit.value = true;
                controller.update();
                Timer(const Duration(seconds: 2), () {
                  controller.canExit.value = false;
                  controller.update();
                });
              }
            },
            child: Scaffold(
              backgroundColor: ColorConstants.background,
              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
              resizeToAvoidBottomInset: false,
              body:Obx(
                  ()=> Stack(
                    children: [
                      PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (value) => controller.selectIndex(value),
                        controller: controller.pageController,
                        children: const [
                          HomeScreenWrapper(),
                          PremiumScreenWrapper(),
                          CategoryScreenWrapper(),
                          // FavouriteScreenWrapper(),
                          SettingsScreenWrapper(),
                        ],
                      ),
                      BottomBarWidget(
                        active: controller.selectedIndex.value,
                        homeTap: () => controller.animateToPage(0),
                        premiumTap: () {
                          // if(!Get.find<SearchScreenController>().searchClick.value){
                          //   Get.find<SearchScreenController>().init();
                          // }
                          controller.animateToPage(1);
                        },
                        categoryTap: () => controller.animateToPage(2),
                        likeTap: () => controller.animateToPage(3),
                        settingTap: () {
                          ///uncomment below line to test notification flow
                          // NotificationManager.showCompletedNotification(category: "Reels",filePath: "");
                          controller.animateToPage(3);
                        },
                      )
                    ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

/// bottom screens

class HomeScreenWrapper extends StatefulWidget {
  const HomeScreenWrapper({super.key});

  @override
  State<HomeScreenWrapper> createState() => _HomeScreenWrapperState();
}

class _HomeScreenWrapperState extends State<HomeScreenWrapper> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const HomeScreen();
  }
}



class CategoryScreenWrapper extends StatefulWidget {
  const CategoryScreenWrapper({super.key});

  @override
  State<CategoryScreenWrapper> createState() => _CategoryScreenWrapperState();
}

class _CategoryScreenWrapperState extends State<CategoryScreenWrapper> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const CategoriesScreen();
  }
}class PremiumScreenWrapper extends StatefulWidget {
  const PremiumScreenWrapper({super.key});

  @override
  State<PremiumScreenWrapper> createState() => _PremiumScreenWrapperState();
}

class _PremiumScreenWrapperState extends State<PremiumScreenWrapper> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const PremiumScreen();
  }
}

class FavouriteScreenWrapper extends StatefulWidget {
  const FavouriteScreenWrapper({super.key});

  @override
  State<FavouriteScreenWrapper> createState() => _FavouriteScreenWrapperState();
}

class _FavouriteScreenWrapperState extends State<FavouriteScreenWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const FavouriteScreen();
  }
}

class SettingsScreenWrapper extends StatefulWidget {
  const SettingsScreenWrapper({super.key});

  @override
  State<SettingsScreenWrapper> createState() => _SettingsScreenWrapperState();
}

class _SettingsScreenWrapperState extends State<SettingsScreenWrapper> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SettingScreen();
  }
}
