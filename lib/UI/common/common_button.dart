import 'package:flutter/material.dart';
import 'package:reels_app/UI/common/headline_body_one_base_widget.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';
import 'package:reels_app/infrastructure/constant/font_constant.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.onTap,
    required this.title,
    this.titleColor, this.bottomSpace, this.updateSpace, this.backgroundColor,
  });

  final GestureTapCallback onTap;
  final String title;
  final Color? titleColor;
  final Color? backgroundColor;
  final bool? bottomSpace;
  final bool? updateSpace;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: updateSpace ?? false ? 12 : 18, horizontal: 24),
        margin: EdgeInsets.only(bottom: bottomSpace ?? true ? 24 : 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: backgroundColor,
            gradient: backgroundColor == null ? const LinearGradient(
              colors: [
                // ColorConstants.orange,
                Color(0xFFF39654),
                Color(0xFFF07721),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ) : null,
        ),
        child: HeadlineBodyOneBaseWidget(
          title: title,
          fontSize: 16,
          fontFamily: FontConstant.satoshiMedium,
          fontWeight: FontWeight.w600,
          titleColor: titleColor ?? ColorConstants.black,
        ),
      ),
    );
  }
}
