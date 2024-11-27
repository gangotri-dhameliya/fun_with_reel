import 'package:get/get.dart';
import 'package:reels_app/UI/screens/SettingSection/setting_controller.dart';

class SettingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SettingController());
  }

}