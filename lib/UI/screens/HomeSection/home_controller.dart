import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:reels_app/UI/common/common_seekbar.dart';
import 'package:reels_app/infrastructure/model/reels_data_model.dart';
import 'package:reels_app/infrastructure/model/ringtone_data_model.dart';
import 'package:reels_app/infrastructure/services/api_service.dart';
import 'package:reels_app/infrastructure/storage/database_helper.dart';
import 'package:reels_app/infrastructure/storage/shared_preference_service.dart';
import 'package:rxdart/rxdart.dart' as rx;
import 'package:permission_handler/permission_handler.dart' as permission;


class HomeController extends GetxController with GetTickerProviderStateMixin{
  RxList<ReelDataModel> reels = <ReelDataModel>[].obs;
  RxList<ReelDataModel> userFavouriteReels = <ReelDataModel>[].obs;
  RxList<ReelDataModel> trendingReels = <ReelDataModel>[].obs;
  RxList<ReelDataModel> liveWallpapers = <ReelDataModel>[].obs;
  RxList<RingtoneDataModel> ringtones = <RingtoneDataModel>[].obs;
  RxList<String> ringtonesDurationDataList = <String>[].obs;

  RxBool isLoading = true.obs;
  RxBool ringtoneLoading = true.obs;
  RxBool liveWallpaperLoading = true.obs;
  RxBool categoriesLoading = true.obs;
  RxBool isRingtonePlaying = false.obs;
  RxBool isCategoryPlaying = false.obs;
  DatabaseHelper db = DatabaseHelper();

  final ScrollController sliverScrollController = ScrollController();
  RxBool isPinned = false.obs;

  RxInt selectedRingtoneIndex = (-1).obs;

  setSelectedRingtoneIndexToZero(PositionData? positionData) async{
    await Future.delayed(const Duration(seconds: 1));
    selectedRingtoneIndex.value = (-1);
    update();
  }

  final player = AudioPlayer();
  playSong({required String url})async{
    player.pause();
    if(!player.playing){
      final duration = await player.setUrl(url);
    log("Duration of song ${duration!.inSeconds}");
    }
    isRingtonePlaying.value = true;
    player.play();
    update();
  }

  playPauseSong(){
    if(player.playing){
      player.pause();
      rotationController.stop(canceled: false);
      isRingtonePlaying.value = false;
    }else{
      player.play();
      rotationController.forward();
      rotationController.repeat();
      isRingtonePlaying.value = true;
    }
    update();
  }

  late AnimationController rotationController = AnimationController(vsync: this, duration: const Duration(seconds: 20))..repeat();

  Stream<PositionData> get positionDataStream =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));


  getReels() async {
    String storeReel = await SharedPreferenceService.getReels;
    if(storeReel.isNotEmpty){
      reels.value = ReelDataModel.decode(storeReel);
    }else{
      await ApiService.getReels(workSheetId: 0).then((value) async {
        reels.value = value;
        await SharedPreferenceService.saveReels(ReelDataModel.encode(value));
      });
    }
    reels.value = ReelDataModel.decode(storeReel);
    reels.removeWhere((element) => element.isPremium=='true');
    reels.shuffle();
    // reels.removeWhere((element) => userFavouriteReels.map((e) => e.reelsId).toList().contains(element.reelsId));
  }

  getUserFavouriteController(){
    SharedPreferenceService.getFavouriteReels.then((value) {
      if(value.isNotEmpty){
        userFavouriteReels.addAll(ReelDataModel.decode(value));
        
      }
      update();
    });
  }

  // getTrendingReels() async {
  //   trendingReels.value = await ApiService.getReels(workSheetId: ApiConstant.trendingSheetId);
  //   trendingReels.shuffle();
  // }

  // getLiveWallpaper() async{
  //   liveWallpaperLoading.value = true;
  //   liveWallpapers.value = await ApiService.getReels(workSheetId: ApiConstant.liveWallpaperSheetId);
  //   liveWallpaperLoading.value = false;
  // }

  final demo = AudioPlayer();

  // getCategories()async{
  //   isCategoryPlaying.value = true;
  //   allCategoryList.value = await ApiService.getCategories();
  //
  //   isCategoryPlaying.value = false;
  // }



  init() async{
   // getCategories();
   //  getTrendingReels();
    // if(Platform.isAndroid){
    //   getLiveWallpaper();
    // }
    isLoading.value = true;
    getUserFavouriteController();
    await getReels();
    bool notification = await permission.Permission.notification.isGranted;
    if(!notification) {
      permission.Permission.notification.request();
    }
    isLoading.value = false;
  }

  @override
  void onInit() async{
    super.onInit();
    await init();
    sliverScrollController.addListener(() {
      print(sliverScrollController.offset);
      if (sliverScrollController.hasClients &&
          sliverScrollController.offset > kToolbarHeight) {
        if(!isPinned.value){
          isPinned.value = true;
          update();
        }
      } else if (sliverScrollController.hasClients &&
          sliverScrollController.offset < kToolbarHeight) {
        if(isPinned.value){
          isPinned.value = false;
          update();
        }
      }
    });
  }
}