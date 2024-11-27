import 'package:flutter/material.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorConstants.white,
      ),
    );
  }
}
