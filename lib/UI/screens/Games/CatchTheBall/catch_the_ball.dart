import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:reels_app/UI/common/headline_body_one_base_widget.dart';
import 'package:reels_app/UI/screens/SettingSection/setting_controller.dart';
import 'package:reels_app/infrastructure/AdHelper/ad_helper.dart';
import 'package:reels_app/infrastructure/AdHelper/banner_ad.dart';
import 'package:reels_app/infrastructure/constant/app_constant.dart';
import 'package:reels_app/infrastructure/constant/image_constant.dart';
import 'package:reels_app/infrastructure/storage/shared_preference_service.dart';

class CatchTheBallScreen extends StatefulWidget {
  void Function() onTargetAchieve;
  int winPoint;
  int winingScore;
   CatchTheBallScreen({required this.onTargetAchieve,required this.winPoint,required this.winingScore});
  @override
  _CatchTheBallScreenState createState() => _CatchTheBallScreenState();
}

class _CatchTheBallScreenState extends State<CatchTheBallScreen> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;
  int _score = 0;
  late Timer _timer;
  List<Offset> _ballPositions = [];
  final _random = Random();
  bool isWinner = false;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      _addBall();
    });
  }

  void _addBall() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double randomX = _random.nextDouble() * (screenWidth - 50);
    double randomY = _random.nextDouble() * (screenHeight - 50);
    _ballPositions.add(Offset(randomX, randomY));
    setState(() {});
  }

  void _updateBallPositions() {
    for (int i = 0; i < _ballPositions.length; i++) {
      _ballPositions[i] += Offset(0, 5);
    }
    setState(() {});
  }

  void _onTapDown(TapDownDetails details) {
    for (int i = 0; i < _ballPositions.length; i++) {
      double distance = (_ballPositions[i] - details.localPosition).distance;
      if (distance < 25) {
        _ballPositions.removeAt(i);
        _score++;
        if(_score >= widget.winingScore){
          widget.onTargetAchieve;
          setState(() {
            isWinner = true;
            _timer.cancel();
          });
        }
        break;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 62),
        child: GestureDetector(
          onTapDown: _onTapDown,
          child: Container(
            color: Colors.white,
            child:
            Stack(
              children: [
                for (var position in _ballPositions)
                  Positioned(
                    left: position.dx,
                    top: position.dy,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: Text(
                    'Score: $_score',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: Text(
                    'Catch the Ball',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                if(!isWinner)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BannerAdView()),
                  ),
                if(isWinner)
                  UserGameWiningWidget(winPoint: widget.winPoint),

              ],
            )
        ),
      ),
    ),);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

// Widget UserGameWiningWidget({required int winPoint,required context}){
//
// }

class UserGameWiningWidget extends StatefulWidget {
  UserGameWiningWidget({super.key,required this.winPoint});
  int winPoint;
  @override
  State<UserGameWiningWidget> createState() => _UserGameWiningWidgetState();
}

class _UserGameWiningWidgetState extends State<UserGameWiningWidget> {
  bool showRewardAd = false;
  bool isADLoading = false;
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: MediaQuery.sizeOf(context).height * .4,
              child: Lottie.asset(ImageConstant.celebration),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      AppConstants.congratulation.tr,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        HeadlineBodyOneBaseWidget(
                          title: AppConstants.youEarned.tr,
                          titleColor: Colors.black,
                          fontSize: 18,
                        ),
                        AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              '${!showRewardAd ? widget.winPoint :widget.winPoint*2} ${AppConstants.streakPoint.tr}',
                              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              speed: Duration(milliseconds: 200),
                            ),
                          ],
                          totalRepeatCount: 1,
                        ),

                      ],
                    ),
                    if(!showRewardAd)
                    ...[
                      SizedBox(height: 10),
                      !isADLoading ?
                      Container(
                        height: 70,
                        width: 200,
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isADLoading = true;
                              });

                              AdHelper.createRewardedAd(
                                  onDismissed: () {
                                    // Get.back();
                                    setState(() {
                                      isADLoading = false;
                                    });
                                  },
                                  onUserEarnedReward: () async {
                                    int streakPoint = await SharedPreferenceService.getUserStreakPoint;
                                    SharedPreferenceService.userStreakPoint(streakPoint+ widget.winPoint);
                                    Get.find<SettingController>().strikePoint.value = streakPoint+widget.winPoint;
                                    Get.find<SettingController>().update();
                                    setState(() {
                                      showRewardAd = true;
                                      isADLoading = false;
                                    });
                                  },
                              );
                            },
                            child: Image.asset(ImageConstant.adButton)),
                      ) : SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(color: Colors.blue,backgroundColor: Colors.white,)),
                      Padding(
                        padding: const EdgeInsets.only(right: 24,left: 24,top: 10),
                        child: HeadlineBodyOneBaseWidget(
                          titleColor: Colors.black,
                          title: AppConstants.doubleReward.tr,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          titleTextAlign: TextAlign.center,
                        ),
                      ),
                    ]

                  ],
                ),
              ),

            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BannerAdView()),
          ),
        ],
      ),
    );

  }
}


Widget UserGameLooseWidget(){
  return Stack(
    children: [
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 250,
                  width: 250,
                  child: Lottie.asset(ImageConstant.loose),
                ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Text(
                AppConstants.oops.tr,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),


          ],
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BannerAdView()),
      ),
    ],
  );

}
