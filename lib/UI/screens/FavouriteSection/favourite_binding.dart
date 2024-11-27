import 'package:get/get.dart';
import 'package:reels_app/UI/screens/FavouriteSection/favourite_controller.dart';

class FavouriteBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => FavouriteController());
  }

}