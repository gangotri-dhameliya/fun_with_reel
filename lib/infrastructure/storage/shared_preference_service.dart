import 'package:flutter/foundation.dart';
import 'package:reels_app/infrastructure/constant/storage_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static SharedPreferenceService? _instance;
  static SharedPreferences? _preferences;
  static Future<SharedPreferenceService> getInstance() async {
    _instance ??= SharedPreferenceService();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }
  // General Methods: ----------------------------------------------------------

  static clearPreference() async {
    await getInstance();
    await _preferences!.clear();
  }

  static Future<void> saveValue(String key, String value) async {
    await getInstance();
    await _preferences!.setString(key, value);
  }

  static Future<String> getValue(String key) async {
    await getInstance();
    try {
      return _preferences!.getString(key) ?? "";
    } catch (e) {
      return '';
    }
  }

  static Future<void> saveBoolValue(String key, bool value) async {
    await getInstance();
    await _preferences!.setBool(key, value);
  }

  static Future<bool?> getBoolValue(String key) async {
    await getInstance();
    try {
      return _preferences!.getBool(key);
    } catch (e) {
      return null;
    }
  }

  static Future<void> removeValue(String key) async {
    await getInstance();
    try {
      await _preferences!.remove(key);
    } catch (e) {
      if (kDebugMode) {
        print("remove value : ${e.runtimeType.toString()}");
      }
    }
  }

  static Future<bool> checkIsKeyAvailable(String key) async {
    await getInstance();
    return _preferences!.containsKey(key);
  }

  // User Name
  static Future<String> get getUserName async {
    await getInstance();
    return _preferences!.getString(StorageConstants.userNameKey) ?? "";
  }

  static Future<void> saveUserName(String userName) async {
    await getInstance();
    await _preferences!.setString(StorageConstants.userNameKey, userName);
  }

  // User Email
  static Future<void> saveUserEmail(String userId) async {
    await getInstance();
    await _preferences!.setString(StorageConstants.userEmailKey, userId);
  }

  static Future<String> get getUserEmail async {
    await getInstance();
    return _preferences!.getString(StorageConstants.userEmailKey) ?? "";
  }

  // show onboarding screen
  static Future<void> saveShowOnboardingScreen(bool value) async {
    await getInstance();
    await _preferences!.setBool(StorageConstants.showOnboardingScreenKey, value);
  }

  static Future<bool> get getShowOnboardingScreen async {
    await getInstance();
    return _preferences!.getBool(StorageConstants.showOnboardingScreenKey) ?? true;
  }

  // User premium wallpaper limit
  static Future<void> savePremiumWallpaperLimit(String count) async {
    await getInstance();
    await _preferences!.setString(StorageConstants.premiumWallpaperLimitKey, count);
  }

  static Future<String> get getPremiumWallpaperLimit async {
    await getInstance();
    return _preferences!.getString(StorageConstants.premiumWallpaperLimitKey) ?? "";
  }


  static Future<void> saveFavouriteReels(String reelsDataModel) async {
    await getInstance();
    await _preferences!.setString(StorageConstants.userFavouriteReels, reelsDataModel);
  }

  static Future<String> get getFavouriteReels async {
    await getInstance();
    return _preferences!.getString(StorageConstants.userFavouriteReels) ?? "";
  }

  static Future<void> saveReels(String reels) async {
    await getInstance();
    await _preferences!.setString(StorageConstants.reels, reels);
  }

  static Future<String> get getReels async {
    await getInstance();
    return _preferences!.getString(StorageConstants.reels) ?? "";
  }

  static Future<void> saveReelsCategories(String reelsCategory) async {
    await getInstance();
    await _preferences!.setString(StorageConstants.category, reelsCategory);
  }

  static Future<String> get getReelsCategories async {
    await getInstance();
    return _preferences!.getString(StorageConstants.category) ?? "";
  }
  //
  static Future<void> saveDate(String date) async {
    await getInstance();
    await _preferences!.setString(StorageConstants.dateKey, date);
  }

  static Future<String> get getDate async {
    await getInstance();
    return _preferences!.getString(StorageConstants.dateKey) ?? "";
  }

  // show notification
  static Future<void> saveShowNotification(bool value) async {
    await getInstance();
    await _preferences!.setBool(StorageConstants.showNotificationKey, value);
  }

  static Future<bool> get getShowNotification async {
    await getInstance();
    return _preferences!.getBool(StorageConstants.showNotificationKey) ?? true;
  }

  static Future<void> userStreakPoint(int value) async {
    await getInstance();
    await _preferences!.setInt(StorageConstants.userStreakPoint, value);
  }

  static Future<int> get getUserStreakPoint async {
    await getInstance();
    return _preferences!.getInt(StorageConstants.userStreakPoint) ?? 0;
  }

}
