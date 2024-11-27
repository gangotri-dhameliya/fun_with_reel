import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reels_app/UI/screens/SettingSection/setting_controller.dart';
import 'package:reels_app/infrastructure/model/reels_data_model.dart';
import 'package:reels_app/infrastructure/package/card_swiper/src/swiper_controller.dart';
import 'package:reels_app/infrastructure/package/reel_viewer/src/components/screen_options.dart';
import 'package:reels_app/infrastructure/package/reel_viewer/src/utils/url_checker.dart';
import 'package:reels_app/infrastructure/storage/shared_preference_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'components/like_icon.dart';

class ReelsPage extends StatefulWidget {
  final ReelDataModel item;
  final bool showVerifiedTick;
  final Function(String)? onShare;
  final Function(String)? onLike;
  final Function(String)? onComment;
  final Function()? onClickMoreBtn;
  final Function()? onFollow;
  final SwiperController swiperController;
  final bool showProgressIndicator;
  const ReelsPage({
    Key? key,
    required this.item,
    this.showVerifiedTick = true,
    this.onClickMoreBtn,
    this.onComment,
    this.onFollow,
    this.onLike,
    this.onShare,
    this.showProgressIndicator = true,
    required this.swiperController,
  }) : super(key: key);

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _liked = false;
  bool isPlayed = true;
  @override
  void initState() {
    super.initState();
    if (!UrlChecker.isImageUrl(widget.item.videoUrl!) && UrlChecker.isValid(widget.item.videoUrl!)) {
      initializePlayer();
    }
  }

  Future initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.item.videoUrl!);
    await Future.wait([_videoPlayerController.initialize()]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      showControls: false,
      looping: false,
    );
    setState(() {});
    _videoPlayerController.addListener(() async {
      if (_videoPlayerController.value.position ==
          _videoPlayerController.value.duration) {
        widget.swiperController.next();
        int streakPoint = await SharedPreferenceService.getUserStreakPoint;
        SharedPreferenceService.userStreakPoint(streakPoint+1);
        Get.find<SettingController>().strikePoint.value = streakPoint+1;
        Get.find<SettingController>().update();
        log("Reel Streak point ===== ${streakPoint}");
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    if (_chewieController != null) {
      _chewieController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  getVideoView();
  }

  Widget getVideoView() {
    return Stack(
      fit: StackFit.expand,
      children: [
        _chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized
            ? SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GestureDetector(
                onTap: () {
                  if (isPlayed) {
                    _chewieController!.videoPlayerController.pause();

                    setState(() {
                      isPlayed = false;
                    });
                  }else{
                    _chewieController!.videoPlayerController.play();

                    setState(() {
                      isPlayed = true;
                    });
                  }
                },
                child: Chewie(
                  controller: _chewieController!,
                ),
              ),
            )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Loading...')
                ],
              ),
        if (!isPlayed)
          const Center(
            child: LikeIcon(),
          ),
        if (widget.showProgressIndicator)
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: VideoProgressIndicator(
              _videoPlayerController,
              allowScrubbing: false,
              colors: VideoProgressColors(
                backgroundColor: Colors.white24,
                bufferedColor: Colors.white24,
                playedColor: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
        ScreenOptions(
          onClickMoreBtn: widget.onClickMoreBtn,
          onComment: widget.onComment,
          onFollow: widget.onFollow,
          onLike: widget.onLike,
          onShare: widget.onShare,
          showVerifiedTick: widget.showVerifiedTick,
          item: widget.item,
        )
      ],
    );
  }
}
