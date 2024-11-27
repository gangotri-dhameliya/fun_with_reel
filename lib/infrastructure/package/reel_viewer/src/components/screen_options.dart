import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:reels_app/UI/screens/CategoriesSection/catregory_controller.dart';
import 'package:reels_app/UI/screens/FavouriteSection/favourite_controller.dart';
import 'package:reels_app/UI/screens/HomeSection/Widget/get_premium_dialog.dart';
import 'package:reels_app/UI/screens/MainSection/main_screen_controller.dart';
import 'package:reels_app/UI/screens/MainSection/widgets/bottom_bar_widget.dart';
import 'package:reels_app/infrastructure/AdHelper/ad_helper.dart';
import 'package:reels_app/infrastructure/constant/app_constant.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';
import 'package:reels_app/infrastructure/constant/toast.dart';
import 'package:reels_app/infrastructure/model/reels_data_model.dart';
import 'package:reels_app/infrastructure/storage/shared_preference_service.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:reels_app/infrastructure/utils/notification_manager.dart';
import 'package:share_plus/share_plus.dart';


class ScreenOptions extends StatefulWidget {
  final ReelDataModel item;
  final bool showVerifiedTick;
  final Function(String)? onShare;
  final Function(String)? onLike;
  final Function(String)? onComment;
  final Function()? onClickMoreBtn;
  final Function()? onFollow;

  const ScreenOptions({
    Key? key,
    required this.item,
    this.showVerifiedTick = true,
    this.onClickMoreBtn,
    this.onComment,
    this.onFollow,
    this.onLike,
    this.onShare,
  }) : super(key: key);

  @override
  State<ScreenOptions> createState() => _ScreenOptionsState();
}

class _ScreenOptionsState extends State<ScreenOptions> {
  bool videoSharingProgress = false;
  bool videoDownloadProgress = false;
  bool adLoadingInProgress = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferenceService.getFavouriteReels,
      builder: (context, snapshot) {
        if(snapshot.data != null){
          List<ReelDataModel> decodedReelsList = ReelDataModel.decode(snapshot.data != "" ? snapshot.data!: "[]");

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Padding(
                  padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight + 100),
                  child: Obx(
                    ()=> Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if(Get.find<MainScreenController>().showMoreMenu.value)
                        Column(
                          children: [
                            if (decodedReelsList.isEmpty || !decodedReelsList.map((e) => e.reelsId).toList().contains(widget.item.reelsId))
                              AnimatedBuilder(
                                animation: Get.find<MainScreenController>().animationController,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset: Offset(0,Tween<double>(begin: 70, end: 0).animate(Get.find<MainScreenController>().animationController).value,),
                                    child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorConstants.black.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(16)
                                    ),
                                    constraints: BoxConstraints(maxHeight: 48,maxWidth: 48),

                                    padding: EdgeInsets.all(4),
                                    child: IconButton(
                                        icon: const Icon(Icons.favorite_outline,
                                            color: Colors.white),
                                        onPressed: () async {
                                          // onLike!(item.videoUrl!);

                                          decodedReelsList.add(widget.item);
                                          Get.put(FavouriteController()).reels.add(widget.item);
                                          Get.put(CategoryController()).favouriteReels.add(widget.item);
                                          await SharedPreferenceService.saveFavouriteReels(ReelDataModel.encode(decodedReelsList));
                                          setState(() {});
                                          Get.find<FavouriteController>().update();
                                          Get.find<CategoryController>().update();
                                        }
                                      ),
                                    ),
                                  );
                                },
                              ),
                            if (decodedReelsList.isNotEmpty && decodedReelsList.map((e) => e.reelsId).toList().contains(widget.item.reelsId))
                            AnimatedBuilder(
                              animation: Get.find<MainScreenController>().animationController,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0,Tween<double>(begin: 70, end: 0).animate(Get.find<MainScreenController>().animationController).value, ),

                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorConstants.black.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(16)
                                    ),
                                    constraints: BoxConstraints(maxHeight: 48,maxWidth: 48),

                                    padding: EdgeInsets.all(4),
                                    child: IconButton(
                                      icon: const Icon(Icons.favorite_rounded,
                                          color: Colors.red),
                                      onPressed: () async {

                                        decodedReelsList.removeWhere((element) => element.reelsId == widget.item.reelsId);
                                        setState(() {});
                                        Get.put(FavouriteController()).reels.removeWhere((element) => element.reelsId == widget.item.reelsId);
                                        Get.put(CategoryController()).favouriteReels.removeWhere((element) => element.reelsId == widget.item.reelsId);
                                        await SharedPreferenceService.saveFavouriteReels(ReelDataModel.encode(decodedReelsList));
                                        setState(() {});
                                        Get.find<FavouriteController>().update();
                                        Get.find<CategoryController>().update();

                                      },
                                    ),),
                                );
                              },
                            ),
                            // Text(NumbersToShort.convertNumToShort(item.likeCount),
                            //     style: const TextStyle(color: Colors.white)),
                            const SizedBox(height: 20),
                            // IconButton(
                            //   icon:
                            //       const Icon(Icons.comment_rounded, color: Colors.white),
                            //   onPressed: () {
                            // if(onComment!=null)  {  showModalBottomSheet(
                            //       barrierColor: Colors.transparent,
                            //       context: context,
                            //       builder: (ctx) => CommentBottomSheet(commentList: item.commentList??[],onComment: onComment)
                            //     );}
                            //   },
                            // ),
                            // Text(NumbersToShort.convertNumToShort(item.commentList?.length??0), style: const TextStyle(color: Colors.white)),
                            // const SizedBox(height: 20),
                            AnimatedBuilder(
                              animation: Get.find<MainScreenController>().animationController,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0,Tween<double>(begin: 70, end: 0).animate(Get.find<MainScreenController>().animationController).value,),

                                  child: InkWell(
                                    onTap: videoSharingProgress ? (){}:() {
                                      Get.dialog(
                                          GetPremiumDialogView(
                                            subtitle: AppConstants.upgradeToPremiumShare.tr,
                                            onWatchAd: videoSharingProgress ?(){}:() {
                                              setState(() {
                                                videoSharingProgress = true;
                                              });
                                              AdHelper.createRewardedAd(
                                                onDismissed: () {
                                                  Get.back();
                                                  setState(() {
                                                    videoSharingProgress = false;
                                                  });
                                                },
                                                onUserEarnedReward: () async {
                                                  try {
                                                    var response = await http.get(Uri.parse(widget.item.videoUrl!));
                                                    final dir = Platform.isAndroid ? await getApplicationDocumentsDirectory() : await getApplicationSupportDirectory();

                                                    var filePath = '${dir.path}/ReelApp';
                                                    var fileName = '${DateTime.now().millisecondsSinceEpoch}.mp4';

                                                    File reelsPath = File("$filePath/$fileName");

                                                    if (await Directory(filePath).exists()) {
                                                      await reelsPath.writeAsBytes(response.bodyBytes);
                                                    } else {
                                                      await Directory(filePath).create(recursive: true);
                                                      await reelsPath.writeAsBytes(response.bodyBytes);
                                                    }
                                                    Share.shareFiles([reelsPath.path] ,subject: AppConstants.shareAppTxt);
                                                    setState(() {
                                                      videoSharingProgress = false;
                                                    });
                                                  } on Exception catch (e) {
                                                    // TODO
                                                    log("Video Sharing error ===> $e");
                                                    setState(() {
                                                      videoSharingProgress = false;
                                                    });
                                                  }
                                                },
                                              );
                                            },),
                                          useSafeArea: false,
                                          barrierDismissible: false
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: ColorConstants.black.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(16)
                                      ),

                                      padding: EdgeInsets.only(left: 8,right: 14,top: 14,bottom: 8),
                                      child: SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Transform(
                                          transform: Matrix4.rotationZ(5.8),
                                          child: const Icon(
                                            Icons.send,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 20),

                            // if (widget.onShare != null)
                            AnimatedBuilder(
                              animation: Get.find<MainScreenController>().animationController,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0,Tween<double>(begin: 70, end: 0).animate(Get.find<MainScreenController>().animationController).value,),
                                  child: InkWell(
                                    onTap: videoDownloadProgress ? (){}:() {
                                      Get.dialog(
                                          GetPremiumDialogView(
                                            subtitle: AppConstants.upgradeToPremium.tr,
                                            onWatchAd: videoDownloadProgress ? (){}:() {
                                              setState(() {
                                                videoDownloadProgress = true;
                                              });
                                              AdHelper.createRewardedAd(
                                                onDismissed: () {
                                                  Get.back();
                                                  setState(() {
                                                    videoSharingProgress = false;
                                                  });
                                                },
                                                onUserEarnedReward: () async {
                                                  String _downloadMessage = '';

                                                  Get.back();
                                                  try {
                                                    var response = await http.get(Uri.parse(widget.item.videoUrl!));
                                                    final dir = Platform.isAndroid ? await getApplicationDocumentsDirectory() : await getApplicationSupportDirectory();

                                                    var filePath = '${dir!.path}/Reel App';
                                                    var fileName = '${DateTime.now().millisecondsSinceEpoch}.mp4';

                                                    File reelsPath = File("$filePath/$fileName");
                                                    File androidPath = File("/storage/emulated/0/Pictures/$fileName");

                                                    if (await Directory(filePath).exists()) {
                                                      await reelsPath.writeAsBytes(response.bodyBytes);
                                                    } else {
                                                      await Directory(filePath).create(recursive: true);
                                                      await reelsPath.writeAsBytes(response.bodyBytes);

                                                    }
                                                    /// TODO: uncomment this lines if image gallery added in pubspect
                                                    await ImageGallerySaver.saveFile(
                                                      reelsPath.path,
                                                      // quality: 100,
                                                      name: fileName,
                                                    );
                                                    // if(Platform.isAndroid){
                                                    //   debugPrint("----------android downloading");
                                                    //   try {
                                                    //     methodChannel.invokeMethod('downloadWallpaper', {
                                                    //       "imageUrl": widget.item.videoUrl!,
                                                    //       "fileName": "${DateTime.now().millisecondsSinceEpoch}-${widget.item.videoUrl!.split("/").last}"
                                                    //     });
                                                    //   } on PlatformException catch (e) {
                                                    //     Exception("Failed to Invoke: '${e.message}'.");
                                                    //   }
                                                    // }
                                                    if(await SharedPreferenceService.getShowNotification){
                                                      NotificationManager.showCompletedNotification(category: "Reel",filePath: Platform.isAndroid ? reelsPath.path : reelsPath.path);
                                                      log("Download Successfully complete $reelsPath");
                                                    }else{
                                                      showTopToast(msg: AppConstants.videoDownload.tr);
                                                    }
                                                    setState(() {
                                                      videoDownloadProgress = false;
                                                    });
                                                  } catch (e) {
                                                    setState(() {
                                                      _downloadMessage = 'Error downloading video: $e';
                                                    });
                                                    log("Download reels error ===> ${_downloadMessage}");
                                                    showTopToast(msg: _downloadMessage);
                                                    setState(() {
                                                      videoDownloadProgress = false;
                                                    });

                                                  }

                                                },
                                              );
                                            },),
                                          useSafeArea: false,
                                          barrierDismissible: false
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: ColorConstants.black.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(16)
                                      ),
                                      constraints: BoxConstraints(maxHeight: 48,maxWidth: 48),
                                      padding: EdgeInsets.all(12),
                                      child: SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: const Icon(
                                          Icons.arrow_downward_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            // const SizedBox(height: 20),
                            // if (onClickMoreBtn != null)
                            //   IconButton(
                            //     icon: const Icon(Icons.more_vert),
                            //     onPressed: onClickMoreBtn!,
                            //     color: Colors.white,
                            //   ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );

        }else{
          return Container();
        }
      },
    );
  }
}
