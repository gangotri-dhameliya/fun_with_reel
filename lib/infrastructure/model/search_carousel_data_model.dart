import 'dart:convert';

List<SearchCarouselDataModel> searchCarouselDataModelFromJson(String str) => List<SearchCarouselDataModel>.from(json.decode(str).map((x) => SearchCarouselDataModel.fromJson(x)));

String searchCarouselDataModelToJson(List<SearchCarouselDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchCarouselDataModel {
  String? image;
  String? title;
  String? description;
  String? category;

  SearchCarouselDataModel({
    this.image,
    this.title,
    this.description,
    this.category,
  });

  factory SearchCarouselDataModel.fromJson(Map<String, dynamic> json) => SearchCarouselDataModel(
    image: json["image"],
    title: json["title"],
    description: json["description"],
    category: json["category"],
  );

  factory SearchCarouselDataModel.fromSheets(List<String> json) => SearchCarouselDataModel(
    image: json[0],
    title: json[1],
    description: json[2],
    category: "",
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "title": title,
    "description": description,
    "category": category,
  };
}
