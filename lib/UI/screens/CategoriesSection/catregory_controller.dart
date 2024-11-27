import 'dart:convert';

import 'package:get/get.dart';
import 'package:reels_app/infrastructure/model/reels_data_model.dart';
import 'package:reels_app/infrastructure/services/api_service.dart';
import 'package:reels_app/infrastructure/storage/shared_preference_service.dart';

class CategoryController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isCategoryPlaying = false.obs;
  RxList<ReelDataModel> reels = <ReelDataModel>[].obs;
  RxList<String> allCategory = <String>[].obs;

  RxList<ReelDataModel> favouriteReels = <ReelDataModel>[].obs;

  getUserFavouriteController(){
    SharedPreferenceService.getFavouriteReels.then((value) {
      if(value.isNotEmpty){
        favouriteReels.addAll(ReelDataModel.decode(value));
        update();
      }
    });
  }
  getAllReelsData() async {
    String storeReel = await SharedPreferenceService.getReels;
    reels.value = ReelDataModel.decode(storeReel);
    update();
   //  ApiService.getReels(workSheetId: 0).then((value) {
   //    reels.value = value;
   // update();
   //  });
  }



  getCategories() async {
    isCategoryPlaying.value = true;
    update();
    String reelCategory = await SharedPreferenceService.getReelsCategories;
    List<dynamic> dynamicList =jsonDecode(reelCategory);
    allCategory.value = dynamicList.map((dynamic item) => item.toString()).toList();
    if(favouriteReels.isNotEmpty){
      allCategory.insert(0, "");
    }
    isCategoryPlaying.value = false;
    update();
    // ApiService.getCategories().then((value) {
    //   allCategory.value = value;
    //   isCategoryPlaying.value = false;
    //   update();
    // });
  }

  @override
  void onInit() {
    super.onInit();
    getAllReelsData();
    getUserFavouriteController();
    getCategories();

  }
}
