import 'package:get/get.dart';
import 'package:reels_app/UI/screens/HomeSection/home_controller.dart';
import 'package:reels_app/UI/screens/SplashSection/splash_controller.dart';
import 'package:reels_app/infrastructure/services/no_internet_controller.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.put(InternetConnectionController(),permanent: true);
    Get.put(HomeController(),permanent: true);
  }
}