import 'package:flutter/material.dart';
import 'package:reels_app/UI/common/HtmlToRichTextWidget.dart';
import 'package:reels_app/UI/common/common_background.dart';
import 'package:reels_app/UI/common/custom_appbar.dart';
import 'package:reels_app/infrastructure/constant/app_constant.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonBackground(
        topSpace: false,
        child: const SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: "Privacy And Policy"),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    child: HtmlToRichTextWidget(htmlString: AppConstants.privacyPolicyTxt),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}