import 'package:get/get.dart';
import 'package:reels_app/UI/screens/HomeSection/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }

}