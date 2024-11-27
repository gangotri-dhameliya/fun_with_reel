import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:reels_app/infrastructure/constant/app_constant.dart';

class BannerAdView extends StatefulWidget {
  const BannerAdView({super.key});

  @override
  State<BannerAdView> createState() => _BannerAdViewState();
}

class _BannerAdViewState extends State<BannerAdView> {

  BannerAd? bannerAd;
  bool bannerAdLoaded = false;

  getBannerAd() async {

    // final AnchoredAdaptiveBannerAdSize? size =
    // await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
    //     MediaQuery.of(context).size.width.truncate());
    //
    // if (size == null) {
    //   debugPrint('Unable to get height of anchored banner.');
    //   return;
    // }
    bannerAd = BannerAd(
      adUnitId: AppConstants.bannerAdsId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() => bannerAdLoaded = true);
          debugPrint('Banner Ad loaded. $bannerAdLoaded');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugPrint('Banner  Ad failed to load: $error');
        },
        onAdOpened: (Ad ad) {
          debugPrint('Banner Ad opened.');
        },
        onAdClosed: (Ad ad) {
          debugPrint('Banner Ad closed.');
        },
      ),
    );
    await bannerAd?.load();

    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return bannerAdLoaded ? Container(
      margin: const EdgeInsets.only(top: 12),
      constraints: BoxConstraints(
        maxHeight: bannerAd!.size.height.toDouble(),
        maxWidth: bannerAd!.size.width.toDouble(),
        minHeight: bannerAd!.size.height.toDouble(),
        minWidth: bannerAd!.size.width.toDouble(),
      ),
      child: AdWidget(ad: bannerAd!),
    ) : Container(
      height: 26,
    );
  }
}

