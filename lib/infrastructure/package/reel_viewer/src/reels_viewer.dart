import 'dart:math';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reels_app/UI/screens/Games/2048/game_board_2048.dart';
import 'package:reels_app/UI/screens/Games/CatchTheBall/catch_the_ball.dart';
import 'package:reels_app/UI/screens/Games/SnackGame/sanck_game.dart';
import 'package:reels_app/UI/screens/Games/TicTacToe/tic_tac_toe.dart';
import 'package:reels_app/UI/screens/SettingSection/setting_controller.dart';
import 'package:reels_app/infrastructure/model/reels_data_model.dart';
import 'package:reels_app/infrastructure/package/card_swiper/src/swiper.dart';
import 'package:reels_app/infrastructure/package/card_swiper/src/swiper_controller.dart';
import 'package:reels_app/infrastructure/package/reel_viewer/src/reels_page.dart';
import 'package:reels_app/infrastructure/storage/shared_preference_service.dart';

class ReelsViewer extends StatefulWidget {
  /// use reel model and provide list of reels, list contains reels object, object contains url and other parameters
  final List<ReelDataModel> reelsList;

  /// use to show/hide verified tick, by default true
  final bool showVerifiedTick;

  /// function invoke when user click on share btn and return reel url
  final Function(String)? onShare;

  /// function invoke when user click on like btn and return reel url
  final Function(String)? onLike;

  /// function invoke when user click on comment btn and return reel comment
  final Function(String)? onComment;

  /// function invoke when reel change and return current index
  final Function(int)? onIndexChanged;

  /// function invoke when user click on more options btn
  final Function()? onClickMoreBtn;

  /// function invoke when user click on follow btn
  final Function()? onFollow;

  /// for change appbar title
  final String? appbarTitle;

  /// for show/hide appbar, by default true
  final bool showAppbar;

  /// for show/hide video progress indicator, by default true
  final bool showProgressIndicator;

  /// function invoke when user click on back btn
  final Function()? onClickBackArrow;

  const ReelsViewer({
    Key? key,
    required this.reelsList,
    this.showVerifiedTick = true,
    this.onClickMoreBtn,
    this.onComment,
    this.onFollow,
    this.onLike,
    this.onShare,
    this.appbarTitle,
    this.showAppbar = true,
    this.onClickBackArrow,
    this.onIndexChanged,
    this.showProgressIndicator = true,
  }) : super(key: key);

  @override
  State<ReelsViewer> createState() => _ReelsViewerState();
}

class _ReelsViewerState extends State<ReelsViewer> {
  SwiperController controller = SwiperController();


  @override
  void initState() {
    if(widget.reelsList.length>10){

    for (int i = 0; i < widget.reelsList.length; i++) {
      int randomNumber = generateRandomNumber(5, 10);
      dev.log("Random number genrate ====> ${randomNumber}");
      if (i!=0 && i  % 10 == 0) {
        widget.reelsList.insert(i,ReelDataModel(ads: true));
      }
      if (i!=0 && i  % 7 == 0) {
        widget.reelsList.insert(i,ReelDataModel(games: true));
      }
    }
    setState(() {});
    }
    super.initState();
  }

  int generateRandomNumber(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min);
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> gamesList = [Container(),SnackGame(
      onGameOver: (p0) async {
        int streakPoint = await SharedPreferenceService.getUserStreakPoint;
        SharedPreferenceService.userStreakPoint(streakPoint+p0);
        Get.find<SettingController>().strikePoint.value = streakPoint+p0;
        Get.find<SettingController>().update();
    },),
      TicTacToeScreen(
        onGameWin: () async {
          // controller.next();
          int streakPoint = await SharedPreferenceService.getUserStreakPoint;
          SharedPreferenceService.userStreakPoint(streakPoint+1);
          Get.find<SettingController>().strikePoint.value = streakPoint+1;
          Get.find<SettingController>().update();
        },
        onGameLoss: () {
          controller.next();
        },
        winPoint: 1,
      ),
      CatchTheBallScreen(
        onTargetAchieve: () async {
        // controller.next();
        int streakPoint = await SharedPreferenceService.getUserStreakPoint;
        SharedPreferenceService.userStreakPoint(streakPoint+5);
        Get.find<SettingController>().strikePoint.value = streakPoint+5;
        Get.find<SettingController>().update();
        },
        winingScore: 5,
        winPoint: 5,
      ),
      My2048Screen(
        onGameWin: () async {
          int streakPoint = await SharedPreferenceService.getUserStreakPoint;
          SharedPreferenceService.userStreakPoint(streakPoint+10);
          Get.find<SettingController>().strikePoint.value = streakPoint+10;
          Get.find<SettingController>().update();
      },
      winPoint: 10,),
    ];
    // gamesList.shuffle();
    // gamesList.insert(0, Container());
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Stack(
        children: [
          Swiper(
            itemBuilder: (BuildContext context, int index) {

             if(widget.reelsList[index].games==true ){
                if(gamesList.length > index~/7){

                  return gamesList[index~/7];

                }else{
                  return Container(color: Colors.white,);
                }
              }
              else{
                return ReelsPage(
                  item: widget.reelsList[index],
                  onClickMoreBtn: widget.onClickMoreBtn,
                  onComment: widget.onComment,
                  onFollow: widget.onFollow,
                  onLike: widget.onLike,
                  onShare: widget.onShare,
                  showVerifiedTick: widget.showVerifiedTick,
                  swiperController: controller,
                  showProgressIndicator: false,
                );
              }

            },
            controller: controller,
            itemCount: widget.reelsList.length,
            scrollDirection: Axis.vertical,

            onIndexChanged: widget.onIndexChanged,
            loop: false,
          ),
          if (widget.showAppbar)
            Container(
              color: Colors.black26,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: widget.onClickBackArrow ?? () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  Text(
                    widget.appbarTitle ?? 'Reels View',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  const SizedBox(),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
