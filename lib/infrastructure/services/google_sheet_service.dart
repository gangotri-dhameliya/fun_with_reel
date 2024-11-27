import 'package:gsheets/gsheets.dart';
import 'package:reels_app/infrastructure/constant/api_constant.dart';

class GoogleSheetService{
  static GSheets gSheets = GSheets(ApiConstant.credentials);
  static late Spreadsheet spreadsheet;

  static Future<Worksheet?> initReels({required int workSheetId}) async {
    spreadsheet = await gSheets.spreadsheet(ApiConstant.spreadSheetId);
    return spreadsheet.worksheetById(workSheetId);
  }
}