import 'dart:convert';

List<RingtoneDataModel> ringtoneDataModelFromJson(String str) => List<RingtoneDataModel>.from(json.decode(str).map((x) => RingtoneDataModel.fromJson(x)));

String ringtoneDataModelToJson(List<RingtoneDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => RingtoneDataModel.toJson(x))));

class RingtoneDataModel {
  String? image;
  String? name;
  String? ringtone;
  int? premium;
  int? like;

  RingtoneDataModel({
    this.image,
    this.name,
    this.ringtone,
    this.premium,
    this.like,
  });

  factory RingtoneDataModel.fromJson(Map<String, dynamic> json) => RingtoneDataModel(
    image: json["ringtone_image"],
    name: json["name"],
    ringtone: json["ringtone"],
    premium: json["ringtone_premium"],
    like: json["ringtone_like"],
  );

  factory RingtoneDataModel.fromSheets(List<String> json) => RingtoneDataModel(
    image: json[0],
    name: json[1],
    ringtone: json[2],
    premium: int.parse(json[3]),
    like: 0,
  );

  static Map<String, dynamic> toJson(RingtoneDataModel data) => {
    "ringtone_image": data.image,
    "name": data.name,
    "ringtone": data.ringtone,
    "ringtone_premium": data.premium,
    "ringtone_like": data.like,
  };

  static String encode(List<RingtoneDataModel> favourites) => json.encode(
    favourites
        .map<Map<String, dynamic>>((favourite) => RingtoneDataModel.toJson(favourite))
        .toList(),
  );

  static List<RingtoneDataModel> decode(String favourite) =>
      (json.decode(favourite) as List<dynamic>)
          .map<RingtoneDataModel>((item) => RingtoneDataModel.fromJson(item))
          .toList();
}
