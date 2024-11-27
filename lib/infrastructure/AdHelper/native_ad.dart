import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:reels_app/UI/common/headline_body_one_base_widget.dart';
import 'package:reels_app/infrastructure/constant/app_constant.dart';

class NativeAdView extends StatefulWidget {
  const NativeAdView({super.key});

  @override
  State<NativeAdView> createState() => _NativeAdViewState();
}

class _NativeAdViewState extends State<NativeAdView> {
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;

  void loadAd() {
    _nativeAd = NativeAd(
      adUnitId: AppConstants.nativeId,
      factoryId: 'adFactoryExample',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          debugPrint('$NativeAd loaded.');
          setState(() {
            _nativeAdIsLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Dispose the ad here to free resources.
          debugPrint('$NativeAd failedToLoad: $error');
          ad.dispose();
        },
      ),
    )..load();
    // _nativeAd?.load();
  }

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  @override
  Widget build(BuildContext context) {
    return _nativeAdIsLoaded
        ? AdWidget(ad: _nativeAd!)
        : Container(
            height: 650,
            width: 350,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const HeadlineBodyOneBaseWidget(title: "Ad"),
          );
  }
}
