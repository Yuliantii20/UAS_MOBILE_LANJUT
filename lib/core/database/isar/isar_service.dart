import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../../features/home/data/models/news_model.dart';

class IsarService {
  static late Isar isar;

  static Future<void> init() async {
    if (Isar.instanceNames.isNotEmpty) {
      isar = Isar.getInstance()!;
      return;
    }

    final dir = await getApplicationDocumentsDirectory();

    isar = await Isar.open(
      [
        NewsModelSchema,
      ],
      directory: dir.path,
      inspector: true,
    );
  }
}