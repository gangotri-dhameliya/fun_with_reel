import 'dart:developer';

import 'package:gsheets/gsheets.dart';
import 'package:reels_app/infrastructure/model/reels_data_model.dart';
import 'package:reels_app/infrastructure/model/ringtone_data_model.dart';
import 'package:reels_app/infrastructure/model/search_carousel_data_model.dart';
import 'package:reels_app/infrastructure/model/wallpaper_data_model.dart';
import 'package:reels_app/infrastructure/constant/api_constant.dart';
import 'package:reels_app/infrastructure/services/google_sheet_service.dart';

class ApiService {
  // static getWallpapers() async {
  //   final res =
  //       await http.get(Uri.parse(ApiConstant.baseUrl + ApiConstant.wallpaper));
  //
  //   if (res.statusCode == 200) {
  //     return wallpaperDataModelFromJson(res.body);
  //   } else {
  //     throw Exception("Error Fetching Wallpaper Data");
  //   }
  // }

  static Future<List<WallpaperDataModel>> getWallpapers({required int workSheetId}) async {
    try {
      Worksheet? productSheet = await GoogleSheetService.initReels(workSheetId: workSheetId);
      final values = (await productSheet!.values.allRows()).skip(1).toList();
      List<WallpaperDataModel> wallpapers = [];
      for (var data in values) {
        if (data.length == 4) {
          wallpapers.add(WallpaperDataModel.fromSheets(data));
        } else {}
      }
      return wallpapers;
    } catch (e) {
      Exception(e);
      return [];
    }
  }

  static Future<List<ReelDataModel>> getReels({required int workSheetId}) async {
    try {
      Worksheet? productSheet = await GoogleSheetService.initReels(workSheetId: workSheetId);
      final values = (await productSheet!.values.allRows()).skip(1).toList();

      List<ReelDataModel> reels = [];
      for (var data in values) {
        // if (data.length == 4) {
        reels.add(ReelDataModel.fromSheets(data));
        // } else {
        // }
       // log("Reels data print ===> ${data}");
      }

      return reels;
    } catch (e) {
      Exception(e);
      return [];
    }
  }

  static Future<List<String>> getCategories() async {
    try {
      Worksheet? productSheet = await GoogleSheetService.initReels(workSheetId: ApiConstant.categoriesSheetId);
      final values = (await productSheet!.values.allRows()).skip(1).toList();
      List<String> categories = [];
      for (var data in values) {
        categories.add(data.first);
      }

      return categories;
    } catch (e) {
      Exception(e);
      return [];
    }
  }

  static Future<List<RingtoneDataModel>> getRingtone() async {
    try {
      Worksheet? productSheet = await GoogleSheetService.initReels(workSheetId: ApiConstant.ringtoneSheetId);
      final values = (await productSheet!.values.allRows()).skip(1).toList();
      List<RingtoneDataModel> ringtones = [];
      for (var data in values) {
        if (data.length == 4) {
          ringtones.add(RingtoneDataModel.fromSheets(data));
        } else {}
      }
      return ringtones;
    } catch (e) {
      Exception(e);
      return [];
    }
  }

  static Future<List<SearchCarouselDataModel>> getSearchCarousel() async {
    try {
      Worksheet? productSheet = await GoogleSheetService.initReels(workSheetId: ApiConstant.searchCarouselId);
      final values = (await productSheet!.values.allRows()).skip(1).toList();
      List<SearchCarouselDataModel> searchCarouselData = [];
      for (var data in values) {
        searchCarouselData.add(SearchCarouselDataModel.fromSheets(data));
      }
      return searchCarouselData;
    } catch (e) {
      Exception(e);
      return [];
    }
  }
}
