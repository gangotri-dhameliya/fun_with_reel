import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reels_app/UI/screens/HomeSection/home_controller.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';
import 'package:reels_app/infrastructure/constant/image_constant.dart';
import 'package:reels_app/infrastructure/model/reels_data_model.dart';
import 'package:reels_app/infrastructure/package/reel_viewer/src/reels_viewer.dart';

import '../../../infrastructure/storage/shared_preference_service.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Stack(
            children: [
              Container(
                // padding: EdgeInsets.only(top: controller.isPinned.value ? 0 : 20),
                height: double.maxFinite,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ImageConstant.backgroundImg), fit: BoxFit.fill),
                ),
                child: ReelsVideoPage(reels: controller.reels,),
              ),
              Row(
                children: [
                  SvgPicture.asset(ImageConstant.appIcon,height: 24,width: 24,),
                ],
              ).paddingSymmetric(vertical: MediaQuery.of(context).padding.top+24, horizontal: 20),
            ],
          );
        }
      ),
    );
  }
}


class ReelsVideoPage extends StatefulWidget {
  ReelsVideoPage({super.key,required this.reels,this.showBackButton = false});
  List<ReelDataModel> reels;
  bool showBackButton;
  @override
  State<ReelsVideoPage> createState() => _ReelsVideoPageState();
}

class _ReelsVideoPageState extends State<ReelsVideoPage> {

  // List<ReelModel> reelsList = [
  //   ReelModel(
  //       'https://firebasestorage.googleapis.com/v0/b/wallpaperapp-ab019.appspot.com/o/live%20wallpapers%2Fwallpaper-1.mp4?alt=media&token=9714cb11-58b3-47e6-b116-ffa2f0cbbfe0',
  //       ),
  //   ReelModel(
  //     'https://assets.mixkit.co/videos/preview/mixkit-father-and-his-little-daughter-eating-marshmallows-in-nature-39765-large.mp4',
  //
  //   ),
  //   ReelModel(
  //     'https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4',
  //
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    SharedPreferenceService.getFavouriteReels.then((value) {
      log("Got reels like and dislike datatatatat ===> ${value}");

    });
    return Stack(
      children: [

        if(widget.showBackButton)
          Positioned(
            top: 48,
            left: 24,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(100),
              child: Container(
                alignment: Alignment.center,
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: ColorConstants.white.withOpacity(0.1),
                  border: Border.all(color: ColorConstants.white.withOpacity(.25)),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  ImageConstant.backIcon,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                      ColorConstants.white, BlendMode.srcIn),
                ),
              ),
            ),
          ),

        ReelsViewer(
          reelsList: widget.reels,
          onShare: (url) {
            log('Shared reel url ==> $url');
          },
          onLike: (url) async {
            log('Liked reel url ==> $url');
          },
          onFollow: () {
            log('======> Clicked on follow <======');
          },
          onComment: (comment) {
            log('Comment on reel ==> $comment');
          },
          onClickMoreBtn: () {
            log('======> Clicked on more option <======');
          },
          onClickBackArrow: () {
            log('======> Clicked on back arrow <======');
          },
          onIndexChanged: (index){
            log('======> Current Index ======> $index <========');
          },
          showProgressIndicator: true,
          showVerifiedTick: true,
          showAppbar: false,
        ),
      ],
    );
  }
}