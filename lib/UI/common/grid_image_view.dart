import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reels_app/UI/common/premium_badge.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';
import 'package:reels_app/infrastructure/constant/image_constant.dart';
import 'package:reels_app/infrastructure/utils/utils.dart';

class GridImageView extends StatelessWidget {
  const GridImageView({
    super.key,
    required this.imageUrl,
    required this.onTap,
    required this.screen,
    required this.premium,
  });

  final String imageUrl;
  final String screen;
  final GestureTapCallback onTap;
  final int premium;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Hero(
                tag: screen + imageUrl,
                child: CommonImageView(imageUrl: imageUrl),
                // child: CommonImageView(imageUrl: imageUrl),
            ),
            if(premium == 1)
            const Padding(
              padding: EdgeInsets.all(6),
              child: PremiumBadge(),
            ),
          ],
        ),
      ),
    );
  }
}


class CommonImageView extends StatefulWidget {
  const CommonImageView({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  State<CommonImageView> createState() => _CommonImageViewState();
}

class _CommonImageViewState extends State<CommonImageView> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // return Image.network(getImageLink(url: widget.imageUrl),height: 350,fit: BoxFit.cover,);
    return CachedNetworkImage(
      imageUrl: getImageLink(url: widget.imageUrl),
      fit: BoxFit.cover,
      height: 350,
      placeholder: (context, url) => Container(
        height: 350,
        width: double.maxFinite,
        color: ColorConstants.black,
        child: Image.asset(
          ImageConstant.placeholderImg,
          fit: BoxFit.cover,
          height: 350,
        ),
      ),
    );
  }
}
