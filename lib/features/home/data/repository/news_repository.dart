import '../datasource/news_remote_datasource.dart';
import '../local/news_local_datasource.dart';
import '../models/news_model.dart';

class NewsRepository {
  final NewsRemoteDatasource remoteDatasource;
  final NewsLocalDatasource localDatasource;

  NewsRepository(
    this.remoteDatasource,
    this.localDatasource,
  );

  Future<List<NewsModel>> getNews() async {
    try {
      // Ambil data dari API
      final news = await remoteDatasource.getNews();

      // Simpan ke Isar
      if (news.isNotEmpty) {
        await localDatasource.saveNews(news);
      }

      return news;
    } catch (e) {
      // Jika API gagal, ambil data dari Isar
      final offlineNews = await localDatasource.getNews();

      if (offlineNews.isNotEmpty) {
        return offlineNews;
      }

      rethrow;
    }
  }

  Future<List<NewsModel>> getOfflineNews() async {
    return await localDatasource.getNews();
  }

  Future<void> clearOfflineNews() async {
    await localDatasource.clearNews();
  }
}