import 'package:flutter/material.dart';

import '../../../../core/di/injection.dart';
import '../../data/local/favorite_local_datasource.dart';
import '../../data/models/news_model.dart';
import '../widgets/news_card.dart';
import 'detail_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final datasource = locator<FavoriteLocalDatasource>();

  List<NewsModel> favorites = [];

  @override
  void initState() {
    super.initState();
    loadFavorite();
  }

  Future<void> loadFavorite() async {
    favorites = await datasource.getFavorites();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_border,
                size: 80,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                "Belum ada berita favorit",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: loadFavorite,
        child: ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final news = favorites[index];

            return NewsCard(
              news: news,
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailPage(news: news),
                  ),
                );

                await loadFavorite();
              },
            );
          },
        ),
      ),
    );
  }
}