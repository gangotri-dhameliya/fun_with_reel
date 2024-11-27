import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:reels_app/UI/screens/SplashSection/splash_binding.dart';
import 'package:reels_app/firebase_options.dart';
import 'package:reels_app/infrastructure/constant/app_pages.dart';
import 'package:reels_app/infrastructure/constant/color_constant.dart';
import 'package:reels_app/infrastructure/constant/image_constant.dart';
import 'package:reels_app/infrastructure/lang/translation_service.dart';
import 'package:reels_app/infrastructure/storage/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reels_app/infrastructure/utils/notification_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper().init();
  MobileAds.instance
    ..initialize()
    ..updateRequestConfiguration(RequestConfiguration(
      testDeviceIds: <String>["E0D73F2A3BBABFAB57CEB2968B9ED94C"],
    ));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationManager.init();
  await SharedPreferences.getInstance();
  // await FlutterWindowManager.addFlags(
  //     FlutterWindowManager.FLAG_SECURE);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(ImageConstant.imgOnBoarding.image, context);
    precacheImage(ImageConstant.imgUpdateApp.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.orange),
        useMaterial3: true,
      ),
      navigatorObservers: [observer],
      initialBinding: SplashBinding(),
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
      getPages: AppPages.pages,
    );
  }
}
