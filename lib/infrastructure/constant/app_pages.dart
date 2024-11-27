import 'package:get/get.dart';
import 'package:reels_app/UI/screens/CategoriesSection/SubScreen/reel_detail_view.dart';
import 'package:reels_app/UI/screens/CategoriesSection/SubScreen/view_all_screen.dart';
import 'package:reels_app/UI/screens/CategoriesSection/category_binding.dart';
import 'package:reels_app/UI/screens/FavouriteSection/favourite_binding.dart';
import 'package:reels_app/UI/screens/FavouriteSection/favourite_screen.dart';
import 'package:reels_app/UI/screens/HomeSection/home_screen.dart';
import 'package:reels_app/UI/screens/MainSection/main_screen.dart';
import 'package:reels_app/UI/screens/MainSection/main_screen_binding.dart';
import 'package:reels_app/UI/screens/PremiumSection/premium_screen.dart';
import 'package:reels_app/UI/screens/SettingSection/SubScreen/privacy_policy_screen.dart';
import 'package:reels_app/UI/screens/SettingSection/SubScreen/terms_and_condition_screen.dart';
import 'package:reels_app/UI/screens/SettingSection/setting_binding.dart';
import 'package:reels_app/UI/screens/SettingSection/setting_screen.dart';
import 'package:reels_app/UI/screens/SplashSection/splash_binding.dart';
import 'package:reels_app/UI/screens/SplashSection/splash_screen.dart';
import 'package:reels_app/infrastructure/constant/routes_constant.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: RoutesConstant.splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: RoutesConstant.mainScreen,
      page: () => MainScreen(),
      binding: MainScreenBinding(),
    ),
    GetPage(
      name: RoutesConstant.homeScreen,
      page: () => const HomeScreen(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: RoutesConstant.viewAllScreen,
      page: () => const ViewAllScreen(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: RoutesConstant.settingScreen,
      page: () => const SettingScreen(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: RoutesConstant.reelDetailScreen,
      page: () => ReelDetailScreen(reels: []),
      binding: CategoryBinding(),
    ),  GetPage(
      name: RoutesConstant.premiumScreen,
      page: () => PremiumScreen(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: RoutesConstant.favouriteScreen,
      page: () => const FavouriteScreen(),
      binding: FavouriteBinding(),
    ),
    GetPage(
      name: RoutesConstant.termsAndConditionScreen,
      page: () => const TermsAndConditionsScreen(),
    ),
    GetPage(
      name: RoutesConstant.privacyPolicyScreen,
      page: () => const PrivacyPolicyScreen(),
    ),
  ];
}
