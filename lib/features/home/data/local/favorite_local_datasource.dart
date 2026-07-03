import 'package:isar/isar.dart';

import '../../../../core/di/injection.dart';
import '../models/news_model.dart';

class FavoriteLocalDatasource {
  final Isar isar = locator<Isar>();

  Future<List<NewsModel>> getFavorites() async {
    return await isar.newsModels
        .filter()
        .isFavoriteEqualTo(true)
        .findAll();
  }

  Future<bool> isFavorite(NewsModel news) async {
    final result = await isar.newsModels
        .filter()
        .linkEqualTo(news.link)
        .findFirst();

    return result?.isFavorite ?? false;
  }

  Future<void> toggleFavorite(NewsModel news) async {
    await isar.writeTxn(() async {
      final result = await isar.newsModels
          .filter()
          .linkEqualTo(news.link)
          .findFirst();

      if (result != null) {
        result.isFavorite = !result.isFavorite;
        await isar.newsModels.put(result);
      } else {
        news.isFavorite = true;
        await isar.newsModels.put(news);
      }
    });
  }
}