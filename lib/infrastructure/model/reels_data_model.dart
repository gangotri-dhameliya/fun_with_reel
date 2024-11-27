import 'dart:convert';

List<ReelDataModel> reelDataModelFromJson(String str) => List<ReelDataModel>.from(json.decode(str).map((x) => ReelDataModel.fromJson(x)));

List<ReelDataModel> reelDataModelFromSheets(List<List<String>> values) => values.map((value) => ReelDataModel.fromSheets(value)).toList();

String reelDataModelToJson(List<ReelDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => ReelDataModel.toJson(x))));

class ReelDataModel {
  String? videoUrl;
  String? thumbnail;
  String? category;
  bool? isLiked;
  bool ads;
  bool games;
  String? isPremium;
  int? reelsId;
  ReelDataModel({
    this.videoUrl,
    this.category,
    this.thumbnail,
    this.ads=false,
    this.games=false,
    this.isLiked = false,
    this.reelsId,
    this.isPremium='false',
  });

  factory ReelDataModel.fromJson(Map<String, dynamic> json) => ReelDataModel(
    videoUrl: json["reel_url"],
    isLiked: json["isLiked"],
    category: json["category"],
    thumbnail: json["thumbnail"],
    reelsId: json["reelsId"],
    isPremium: json["isPremium"],
  );

  factory ReelDataModel.fromSheets(List<String> json) => ReelDataModel(
    reelsId: int.parse(json[0].toString()),
    videoUrl: json[1].toString(),
    thumbnail: json[2].toString(),
    category: json[3].toString(),
    isPremium: json[4].toString(),

  );

  static Map<String, dynamic> toJson(ReelDataModel data) => {
    "reel_url": data.videoUrl,
    "isLiked": data.isLiked,
    "thumbnail": data.thumbnail,
    "category": data.category,
    "reelsId": data.reelsId,
    "isPremium": data.isPremium,
  };

  static String encode(List<ReelDataModel> favourites) => json.encode(
    favourites
        .map<Map<String, dynamic>>((favourite) => ReelDataModel.toJson(favourite))
        .toList(),
  );

  static List<ReelDataModel> decode(String favourite) =>
      (json.decode(favourite) as List<dynamic>)
          .map<ReelDataModel>((item) => ReelDataModel.fromJson(item))
          .toList();
}
