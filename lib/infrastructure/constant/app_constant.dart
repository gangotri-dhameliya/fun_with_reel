import 'dart:io';

class AppConstants{
  static const String appName = "Reel App";
  static const String category = "category";
  static const String setting = "setting";
  static const String favorite = "favorite";
  static const String viewAll = "viewAll";
  static const String videos = "videos";
  static const String noCategoriesData = "noCategoriesData";
  static const String noFavouriteData = "noFavouriteData";
  static const String noReelsData = "noReelsData";
  static const String getPremium = "getPremium";
  static const String premiumDesc = "premiumDesc";
  static const String pushNotification = "pushNotification";
  static const String shareApp = "shareApp";
  static const String rateUs = "rateUs";
  static const String premiumTitle = "premiumTitle";
  static const String videoDownload = "videoDownload";
  static const String privacyPolicy = "privacyPolicy";
  static const String yourStrike = "yourStrike";
  static const String termsCondition = "termsCondition";
  static const String tapToExit = "tapToExit";
  static const String upgradePremium = "upgradePremium";
  static const String getPremiumNow = "getPremiumNow";
  static const String upgradeToPremium = "upgradeToPremium";
  static const String upgradeToPremiumShare = "upgradeToPremiumShare";
  static const String upgradeToPremiumShow = "upgradeToPremiumShow";
  static const String watchAd = "watchAd";
  static const String congratulation = "congratulation";
  static const String oops = "opps";
  static const String youEarned = "youEarned";
  static const String streakPoint = "streakPoint";
  static const String doubleReward = "doubleReward";


  //test google
  static String nativeId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/2247696110'
      : 'ca-app-pub-3940256099942544/3986624511';
  static String rewardId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/1712485313';
  static String interstitialAd = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';
  static String bannerAdsId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  static String openAppAdId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/3419835294'
      : 'ca-app-pub-3940256099942544/5662855259';


  static const String appLinkTextConstant =
      "";
  static const String iOSAppLinkTextConstant =
      "";

  static String shareAppTxt = '''🌟 Elevate your device's style with $appName 🌟

Transform your screen with a stunning collection of wallpapers handpicked for you. From breathtaking landscapes to sleek abstract designs, ${AppConstants.appName} has it all.

🎨 Explore thousands of high-definition wallpapers and find the perfect match for your device. With easy-to-use features, setting up your new wallpaper is a breeze!

✨ Features:

Explore a vast library of wallpapers in various categories.
Save your favorites for quick access.
Share your favorite wallpapers with friends effortlessly.
📱 Download $appName now and let your device shine!

${Platform.isIOS ? iOSAppLinkTextConstant : appLinkTextConstant}

 #reelwithfun #funnyreel #ReelApp #Personalization
                ''';


  ///Privacy Policy

  static const String privacyPolicyTxt = '''
  <p>Artonest Pvt Ltd. built the $appName app as an Ad Supported app. This Service is provided by DUIUX Infotech Pvt Ltd. at no cost and is intended for use as is. This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service. If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy. The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at $appName unless otherwise defined in this Privacy Policy.<br><br><b>Information Collection and Use</b><br><br>For a better experience, while using our Service, we use device related basic informations like device ID, device Manufacturer, device Model, device OS Version to analyze data for trends and statistics. The information that we request will be retained by us and used as described in this privacy policy. The app does use third party services that may collect information used to identify you. Link to privacy policy of third party service providers used by the app :<br><br><b>Google Play Services</b><br><b>AdMob</b><br><b>Firebase Analytics</b><br><br><b>Log Data</b><br><br>We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.<br><br><b>Cookies</b><br><br>Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory. This Service does not use these “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service. Service Providers We may employ third-party companies and individuals due to the following reasons: To facilitate our Service; To provide the Service on our behalf; To perform Service-related services; or To assist us in analyzing how our Service is used. We want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose. <br><br><b>Security</b><br><br> We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security. <br><br><b>Links to Other Sites</b><br><br> This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services. <br><br><b>Children’s Privacy</b><br><br> These Services do not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do necessary actions. Changes to This Privacy Policy</b> We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately after they are posted on this page. <br><br><b>Contact Us</b><br><br> If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at mailto:support@duiuxinfotech.com.</p>
  ''';

}