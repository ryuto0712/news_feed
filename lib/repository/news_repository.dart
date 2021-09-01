import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';

class NewsRepository {
Future<void> getNews({required SearchType searchType,String? keyword, Category? category})async{
//todo
  print("[repo]search:$searchType/key:$keyword/category:${category!.nameJp}");
}
}