import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reels_app/UI/common/common_background.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';
import 'package:reels_app/infrastructure/constant/image_constant.dart';
import 'package:reels_app/infrastructure/model/reels_data_model.dart';
import 'package:reels_app/infrastructure/package/reel_viewer/src/reels_viewer.dart';

class FavouriteReelsVideoPage extends StatefulWidget {
  FavouriteReelsVideoPage({super.key,required this.reels,this.showBackButton = false,required this.cardIndex});
  List<ReelDataModel> reels;
  bool showBackButton;
  int cardIndex;
  @override
  State<FavouriteReelsVideoPage> createState() => _FavouriteReelsVideoPageState();
}

class _FavouriteReelsVideoPageState extends State<FavouriteReelsVideoPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CommonBackground(
        child: Stack(
          children: [
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
            if(widget.showBackButton)
              Positioned(
                top: 48,
                left: 24,
                child: GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: ColorConstants.white.withOpacity(0.1),
                      border: Border.all(color: ColorConstants.white.withOpacity(.25)),
                      // borderRadius: BorderRadius.circular(100),
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

          ],
        ),
      )
    );
  }
}