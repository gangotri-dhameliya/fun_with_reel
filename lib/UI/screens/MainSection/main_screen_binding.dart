import 'package:get/get.dart';
import 'package:reels_app/UI/screens/CategoriesSection/catregory_controller.dart';
import 'package:reels_app/UI/screens/FavouriteSection/favourite_controller.dart';
import 'package:reels_app/UI/screens/MainSection/main_screen_controller.dart';
import 'package:reels_app/UI/screens/SettingSection/setting_controller.dart';

class MainScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MainScreenController());
    // Get.lazyPut(() => HomeController());
    // Get.lazyPut(() => SearchScreenController());
    Get.lazyPut(() => CategoryController());
    Get.lazyPut(() => FavouriteController());
    Get.lazyPut(() => SettingController());
  }

}