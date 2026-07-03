import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uas_mobile_lanjut/features/home/data/models/news_model.dart';
import 'package:uas_mobile_lanjut/features/home/data/repository/news_repository.dart';
import 'package:uas_mobile_lanjut/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final NewsRepository repository;

  HomeCubit(this.repository) : super(const HomeInitial());

  List<NewsModel> _allNews = [];

  Future<void> loadNews() async {
    emit(const HomeLoading());

    try {
      final news = await repository.getNews();

      _allNews = news;

      emit(HomeLoaded(news));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void searchNews(String keyword) {
    if (keyword.trim().isEmpty) {
      emit(HomeLoaded(_allNews));
      return;
    }

    final result = _allNews.where((news) {
      return news.title
              .toLowerCase()
              .contains(keyword.toLowerCase()) ||
          news.description
              .toLowerCase()
              .contains(keyword.toLowerCase());
    }).toList();

    emit(HomeLoaded(result));
  }
}