import 'dart:convert';

List<WallpaperDataModel> wallpaperDataModelFromJson(String str) => List<WallpaperDataModel>.from(json.decode(str).map((x) => WallpaperDataModel.fromJson(x)));

List<WallpaperDataModel> wallpaperDataModelFromSheets(List<List<String>> values) => values.map((value) => WallpaperDataModel.fromSheets(value)).toList();

String wallpaperDataModelToJson(List<WallpaperDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => WallpaperDataModel.toJson(x))));

class WallpaperDataModel {
  String? category;
  String? image;
  String? thumbnail;
  int? premium;
  int? like;

  WallpaperDataModel({
    this.category,
    this.image,
    this.thumbnail,
    this.premium,
    this.like,
  });

  factory WallpaperDataModel.fromJson(Map<String, dynamic> json) => WallpaperDataModel(
    category: json["category"],
    image: json["image"],
    thumbnail: json["thumbnail"],
    premium: json["premium"],
    like: json["like"],
  );

  factory WallpaperDataModel.fromSheets(List<String> json) => WallpaperDataModel(
    category: json[0],
    image: json[1],
    thumbnail: json[2],
    premium: int.parse(json[3]),
    like: 0,
  );

  static Map<String, dynamic> toJson(WallpaperDataModel data) => {
    "category": data.category,
    "image": data.image,
    "thumbnail": data.thumbnail,
    "premium": data.premium,
    "like": data.like,
  };

  static String encode(List<WallpaperDataModel> favourites) => json.encode(
    favourites
        .map<Map<String, dynamic>>((favourite) => WallpaperDataModel.toJson(favourite))
        .toList(),
  );

  static List<WallpaperDataModel> decode(String favourite) =>
      (json.decode(favourite) as List<dynamic>)
          .map<WallpaperDataModel>((item) => WallpaperDataModel.fromJson(item))
          .toList();
}
