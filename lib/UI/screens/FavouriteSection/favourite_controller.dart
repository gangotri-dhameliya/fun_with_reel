import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:reels_app/infrastructure/model/reels_data_model.dart';
import 'package:reels_app/infrastructure/storage/shared_preference_service.dart';

class FavouriteController extends GetxController {
  RxList<ReelDataModel> reels = <ReelDataModel>[].obs;

  getUserFavouriteController(){
    SharedPreferenceService.getFavouriteReels.then((value) {
      if(value.isNotEmpty){
        reels.addAll(ReelDataModel.decode(value));
        update();
      }
    });
  }
  ScrollController scrollController = ScrollController();
  RxBool isScrolledToBottom = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUserFavouriteController();
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.offset >=
        scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      // Fully scrolled to the bottom
      isScrolledToBottom = true.obs;
      update();
    } else {
      // Not fully scrolled to the bottom
      isScrolledToBottom = false.obs;
      update();

    }
  }
}
