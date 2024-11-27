import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reels_app/UI/common/custom_snackbar.dart';
import 'package:reels_app/UI/common/headline_body_one_base_widget.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';

showTopToast({required String msg,BuildContext ?context,int? duration}){

        Get.closeAllSnackbars();
        return showCustomSnackbar(
            "",
            "",
            duration: Duration(seconds: duration ?? 3),
            backgroundColor: ColorConstants.black.withOpacity(0.7),
            margin: EdgeInsets.symmetric(vertical: 40,horizontal: MediaQuery.of(Get.context!).size.height * .1),
            animationDuration: const Duration(milliseconds: 0),
            boxShadows: [
                BoxShadow(
                    color: Colors.black.withOpacity(.5),
                    blurRadius: 30,
                    offset: const Offset(0,8),
                )
            ],
            messageText: HeadlineBodyOneBaseWidget(
                title: msg,
                fontSize: 12,
                titleColor: Colors.white,
                maxLine: 2,
                titleTextAlign: TextAlign.center,
            ),
        );

}

