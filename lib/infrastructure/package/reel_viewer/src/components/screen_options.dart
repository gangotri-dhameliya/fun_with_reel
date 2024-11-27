
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reels_app/UI/screens/CategoriesSection/catregory_controller.dart';
import 'package:reels_app/UI/screens/FavouriteSection/favourite_controller.dart';
import 'package:reels_app/UI/screens/HomeSection/Widget/get_premium_dialog.dart';
import 'package:reels_app/UI/screens/MainSection/main_screen_controller.dart';
import 'package:reels_app/infrastructure/constant/app_constant.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';
import 'package:reels_app/infrastructure/model/reels_data_model.dart';
import 'package:reels_app/infrastructure/storage/shared_preference_service.dart';


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
