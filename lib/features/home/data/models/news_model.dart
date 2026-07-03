import 'package:isar/isar.dart';

part 'news_model.g.dart';

@collection
class NewsModel {
  Id id = Isar.autoIncrement;

  String title;
  String description;
  String image;
  String link;
  String date;

  bool isFavorite;

  NewsModel({
    this.id = Isar.autoIncrement,
    this.title = "",
    this.description = "",
    this.image = "",
    this.link = "",
    this.date = "",
    this.isFavorite = false,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json["title"] ?? "",
      description: json["contentSnippet"] ?? "",
      image: json["image"]?["large"] ??
          json["image"]?["small"] ??
          "",
      link: json["link"] ?? "",
      date: json["isoDate"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "contentSnippet": description,
      "image": image,
      "link": link,
      "isoDate": date,
    };
  }
}