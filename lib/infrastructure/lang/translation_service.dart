import 'dart:convert';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:reels_app/infrastructure/lang/en.dart';


class TranslationService extends Translations {

  static Locale? get locale =>const Locale('en', 'US');
  //     sharedPreferences!.getString('language') != null ?  sharedPreferences?.getString('language') == 'English'
  //         ? const Locale('en', 'US'):const Locale('ko', 'KR') : const Locale('en', 'US');
  static Locale fallbackLocale =  const Locale('en', 'US');
  // sharedPreferences?.getString('language') == 'English'
  //     ? const Locale('en', 'US'):const Locale('ko', 'KR');

  static final langs = [
    'English',
    // 'Korean',
  ];
  static final locales = [
    const Locale('en', 'US'),
    // const Locale('ko', 'KR'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
    'en': en,
    // 'ko': koLanguage!,
  };



  // Future<Map<String, String>> changeLocale(/*String lang*/) async {
  //   var languageData = await http.get(Uri.parse("https://botnapp.s3.us-east-005.backblazeb2.com/app/translate.json"));
  //   Map<String,dynamic> ko = json.decode(utf8.decode(languageData.bodyBytes))["ko"] ;
  //   // koLanguage = ko.map((key, value) => MapEntry(key, value.toString())).obs;
  //   // log("get callll ===> $koLanguage");
  //   // return koLanguage!;
  // }


}