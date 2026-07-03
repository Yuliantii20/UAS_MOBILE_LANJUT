import 'package:dio/dio.dart';

import '../../../../core/config/env_config.dart';
import '../../../../core/di/injection.dart';
import '../models/news_model.dart';

class NewsRemoteDatasource {
  final Dio dio = locator<Dio>();

  Future<List<NewsModel>> getNews() async {
    print("BASE URL : ${dio.options.baseUrl}");
    print("ENDPOINT : ${EnvConfig.newsEndpoint}");

    final response = await dio.get(
      EnvConfig.newsEndpoint,
    );

    print("REAL URL : ${response.realUri}");
    print("STATUS : ${response.statusCode}");
    print("BODY : ${response.data}");

    final List posts = response.data["data"];

    return posts
        .map((e) => NewsModel.fromJson(e))
        .toList();
  }
}