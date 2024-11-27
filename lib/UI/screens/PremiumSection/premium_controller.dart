import 'package:get/get.dart';
import 'package:reels_app/infrastructure/model/reels_data_model.dart';
import 'package:reels_app/infrastructure/services/api_service.dart';
import 'package:reels_app/infrastructure/storage/shared_preference_service.dart';

class PremiumController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<ReelDataModel> reels = <ReelDataModel>[].obs;

  getAllReelsData() async {
    isLoading = true.obs;
    update();
    String storeReel = await SharedPreferenceService.getReels;
    reels.value = ReelDataModel.decode(storeReel);
    isLoading = false.obs;
    update();

    // ApiService.getReels(workSheetId: 0).then((value) {
    //   print("====>>> reels :: ${value}");
    //   reels.value = value;
    //   isLoading = false.obs;
    //   update();
    // });
  }

  @override
  void onInit() {
    super.onInit();
    getAllReelsData();
  }
}
