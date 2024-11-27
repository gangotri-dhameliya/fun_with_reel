import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:reels_app/infrastructure/constant/app_constant.dart';

class AdHelper {
  static const AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  /// Interstitial Ad
  static InterstitialAd? interstitialAd;
  static int numInterstitialLoadAttempts = 0;

  static void createInterstitialAd({required GestureTapCallback onDismissed}) {
    InterstitialAd.load(
        adUnitId: AppConstants.interstitialAd,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            debugPrint('$ad loaded');
            interstitialAd = ad;
            numInterstitialLoadAttempts = 0;
            showInterstitialAd(onDismissed: onDismissed);
          },
          onAdFailedToLoad: (LoadAdError error) {
            onDismissed();
            debugPrint('InterstitialAd failed to load: $error.');
          },
        ),
    );
  }

  static showInterstitialAd({required GestureTapCallback onDismissed}) {
    if (interstitialAd != null) {
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) =>
            debugPrint('ad onAdShowedFullScreenContent.'),
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          onDismissed();
          debugPrint('ad onAdDismissedFullScreenContent.');
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          debugPrint("====>${error.message}");
          ad.dispose();
          debugPrint('ad onAdFailedToShowFullScreenContent.');
        },
        onAdWillDismissFullScreenContent: (InterstitialAd ad) async {
          debugPrint('ad onAdWillDismissFullScreenContent. 1');
          ad.dispose();
          onDismissed();
          debugPrint('ad onAdWillDismissFullScreenContent. 2');
        },
      );
      // interstitialAd!.setImmersiveMode(true);
      interstitialAd!.show();
      interstitialAd = null;
    } else {
      debugPrint("No ads....");
      onDismissed();
    }
  }

  static InterstitialAd? shareInterstitialAd;

  static void loadShareInterstitialAd({required GestureTapCallback onDismissed}) {
    InterstitialAd.load(
        adUnitId: AppConstants.interstitialAd,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            debugPrint('$ad loaded');
            shareInterstitialAd = ad;
            showShareInterstitialAd(onDismissed: onDismissed);
          },
          onAdFailedToLoad: (LoadAdError error) {
            onDismissed();
            debugPrint('InterstitialAd failed to load: $error.');
          },
        ),
    );
  }

  static showShareInterstitialAd({required GestureTapCallback onDismissed}) {
    if (shareInterstitialAd != null) {
      shareInterstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) =>
            debugPrint('ad onAdShowedFullScreenContent.'),
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          onDismissed();

          shareInterstitialAd = null;
          debugPrint('ad onAdDismissedFullScreenContent.');
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          debugPrint("====>${error.message}");
          ad.dispose();

          shareInterstitialAd = null;
          debugPrint('ad onAdFailedToShowFullScreenContent.');
        },
        onAdWillDismissFullScreenContent: (InterstitialAd ad) async {
          debugPrint('ad onAdWillDismissFullScreenContent. 1');
          ad.dispose();
          onDismissed();

          shareInterstitialAd = null;
          debugPrint('ad onAdWillDismissFullScreenContent. 2');
        },
      );
      // interstitialAd!.setImmersiveMode(true);
      shareInterstitialAd!.show();
    } else {
      debugPrint("No ads....");
      onDismissed();
    }
  }

  ///Reward Ads

  static RewardedAd? rewardedAd;
  static int numRewardedLoadAttempts = 0;

  static void createRewardedAd({
    required GestureTapCallback onDismissed,
    required GestureTapCallback onUserEarnedReward,
  }) {
    RewardedAd.load(
      adUnitId: AppConstants.rewardId,
      request: request,
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          rewardedAd = ad;
          numRewardedLoadAttempts = 0;
          showRewardedAd(
              onDismissed: onDismissed, onUserEarnedReward: onUserEarnedReward);
        },
        onAdFailedToLoad: (LoadAdError error) {
          // captureImage(context: context!);
          onUserEarnedReward();
        },
      ),
    );
  }

  static showRewardedAd({
    required GestureTapCallback onDismissed,
    required GestureTapCallback onUserEarnedReward,
  }) {
    if (rewardedAd != null) {
      rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) =>
            debugPrint('ad onAdShowedFullScreenContent.'),
        onAdDismissedFullScreenContent: (RewardedAd ad) {
          ad.dispose();
          onDismissed();
          debugPrint('ad onAdDismissedFullScreenContent.');
        },
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
          ad.dispose();
          debugPrint('ad onAdFailedToShowFullScreenContent.');
        },
        onAdWillDismissFullScreenContent: (RewardedAd ad) {
          ad.dispose();
          onDismissed();
          debugPrint('ad onAdWillDismissFullScreenContent.');
        },
      );
      // rewardedAd!.setImmersiveMode(true);
      rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) async {
          onUserEarnedReward();
        },
      );
      rewardedAd = null;
    } else {
      // createRewardedAd();
    }
  }
}
