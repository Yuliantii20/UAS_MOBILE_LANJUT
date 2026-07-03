import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/di/injection.dart';
import '../../data/local/favorite_local_datasource.dart';
import '../../data/models/news_model.dart';

class DetailPage extends StatefulWidget {
  final NewsModel news;

  const DetailPage({
    super.key,
    required this.news,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  final favorite = locator<FavoriteLocalDatasource>();

  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    loadFavorite();
  }

  Future<void> loadFavorite() async {
    isFavorite = await favorite.isFavorite(widget.news);
    setState(() {});
  }

  Future<void> toggleFavorite() async {
    await favorite.toggleFavorite(widget.news);

    isFavorite = await favorite.isFavorite(widget.news);

    setState(() {});
  }

  Future<void> openNews() async {
    final uri = Uri.parse(widget.news.link);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final news = widget.news;

    return Scaffold(

      appBar: AppBar(

        title: const Text("Detail Berita"),

        actions: [

          IconButton(

            onPressed: toggleFavorite,

            icon: Icon(

              isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border,

              color: Colors.red,

            ),

          ),

        ],

      ),

      body: SingleChildScrollView(

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Hero(

              tag: news.link,

              child: Image.network(

                news.image,

                width: double.infinity,

                height: 250,

                fit: BoxFit.cover,

                errorBuilder: (_, __, ___) {

                  return Container(

                    height: 250,

                    color: Colors.grey.shade300,

                    child: const Icon(

                      Icons.image,

                      size: 80,

                    ),

                  );

                },

              ),

            ),

            Padding(

              padding: const EdgeInsets.all(16),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(

                    news.title,

                    style: const TextStyle(

                      fontSize: 24,

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                  const SizedBox(height: 12),

                  Row(

                    children: [

                      const Icon(

                        Icons.calendar_today,

                        size: 18,

                        color: Colors.grey,

                      ),

                      const SizedBox(width: 8),

                      Expanded(

                        child: Text(

                          news.date,

                          style: const TextStyle(

                            color: Colors.grey,

                          ),

                        ),

                      ),

                    ],

                  ),

                  const SizedBox(height: 20),

                  Text(

                    news.description,

                    style: const TextStyle(

                      fontSize: 17,

                      height: 1.6,

                    ),

                  ),

                  const SizedBox(height: 30),

                  SizedBox(

                    width: double.infinity,

                    child: ElevatedButton.icon(

                      onPressed: openNews,

                      icon: const Icon(Icons.open_in_browser),

                      label: const Text(

                        "Baca Selengkapnya",

                      ),

                    ),

                  ),

                ],

              ),

            ),

          ],

        ),

      ),

    );

  }

}