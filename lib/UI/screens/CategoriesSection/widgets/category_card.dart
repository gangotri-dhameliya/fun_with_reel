import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reels_app/UI/common/premium_badge.dart';
import 'package:reels_app/infrastructure/constant/image_constant.dart';
import 'package:reels_app/infrastructure/model/reels_data_model.dart';
import 'package:reels_app/infrastructure/utils/common_utils.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.reelsDataModel, this.noMargin = false});

  final ReelDataModel reelsDataModel;
  final bool noMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      margin: noMargin ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: 12),
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
                opacity: .8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: CommonUtils.getImageLink(url: reelsDataModel.thumbnail ?? ""),
                    fit: BoxFit.fill,
                  ),
                )),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.7), Colors.transparent, Colors.transparent, Colors.black.withOpacity(0.65)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
              bottom: 6,
              left: 6,
              child: SvgPicture.asset(ImageConstant.video,
                  height: 12,
                  width: 12,
                  fit: BoxFit
                      .fill) /*Row(

            children: [
              SvgPicture.asset(ImageConstant.video,height: 12,width: 12,fit: BoxFit.fill),
              // SizedBox(width: 4),
              // HeadlineBodyOneBaseWidget( title: "1.1 m",
              // fontFamily:FontConstant.manropeMedium ,
              //   fontSize: 10,
              //   fontWeight: FontWeight.w500,
              //
              // )
            ],
          )*/
              ),
          if(reelsDataModel.isPremium=='true')
          const Padding(padding: EdgeInsets.all(6), child: PremiumBadge()),
        ],
      ),
    );
  }
}
