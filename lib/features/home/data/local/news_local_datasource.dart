import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/news_model.dart';

class NewsLocalDatasource {
  static const String keyNews = "offline_news";

  Future<void> saveNews(List<NewsModel> news) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList = news
        .map((e) => e.toJson())
        .toList();

    await prefs.setString(
      keyNews,
      jsonEncode(jsonList),
    );
  }

  Future<List<NewsModel>> getNews() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(keyNews);

    if (data == null) {
      return [];
    }

    final List decoded = jsonDecode(data);

    return decoded
        .map((e) => NewsModel.fromJson(e))
        .toList();
  }

  // ==========================
  // TAMBAHKAN METHOD INI
  // ==========================
  Future<void> clearNews() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyNews);
  }
}