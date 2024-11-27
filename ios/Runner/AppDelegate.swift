import UIKit
import Flutter
import awesome_notifications
import GoogleMobileAds
import google_mobile_ads
class NativeAdFactoryExample: NSObject, FLTNativeAdFactory {
   func createNativeAd(
       _ nativeAd: GADNativeAd?,
       customOptions: [AnyHashable : Any]?
   ) -> GADNativeAdView? {
       let adView = Bundle.main.loadNibNamed("NativeAdView", owner: nil, options: nil)?.first as? GADNativeAdView

       adView?.nativeAd = nativeAd
       (adView?.headlineView as? UILabel)?.text = nativeAd?.headline
       (adView?.bodyView as? UILabel)?.text = nativeAd?.body
       adView?.bodyView!.isHidden = ((nativeAd?.body) != nil) ? false : true

       (adView?.callToActionView as? UIButton)?.setTitle(
           nativeAd?.callToAction,
           for: .normal)
       adView?.callToActionView!.isHidden = ((nativeAd?.callToAction) != nil) ? false : true

       (adView?.iconView as? UIImageView)?.image = nativeAd?.icon?.image
       adView?.iconView!.isHidden = ((nativeAd?.icon) != nil) ? false : true

       (adView?.storeView as? UILabel)?.text = nativeAd?.store
       adView?.storeView!.isHidden = ((nativeAd?.store) != nil) ? false : true

       (adView?.priceView as? UILabel)?.text = nativeAd?.price
       adView?.priceView?.isHidden = ((nativeAd?.price) != nil) ? false : true

       (adView?.advertiserView as? UILabel)?.text = nativeAd?.advertiser
       adView?.advertiserView!.isHidden = ((nativeAd?.advertiser) != nil) ? false : true
       adView?.callToActionView!.isUserInteractionEnabled = false

       return adView
   }
}


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      SwiftAwesomeNotificationsPlugin.setPluginRegistrantCallback { registry in
                   SwiftAwesomeNotificationsPlugin.register(
                     with: registry.registrar(forPlugin: "io.flutter.plugins.awesomenotifications.AwesomeNotificationsPlugin")!)
               }

       GeneratedPluginRegistrant.register(with: self)
         let nativeAdFactory = NativeAdFactoryExample()
                FLTGoogleMobileAdsPlugin.registerNativeAdFactory(self, factoryId: "adFactoryExample", nativeAdFactory: nativeAdFactory)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
