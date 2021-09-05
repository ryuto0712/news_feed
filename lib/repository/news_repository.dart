import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  static const BASE_URL = "https://newsapi.org/v2/top-headlines?country=js";
  static const API_KEY = "427ede87c3774c88ba1d372e0293abe5";

//todo 現時点ではarticleを作成してないのでエラー
  //todo 戻り値を設定する理由は戻り値によって、変更を返すため
  Future<void> getNews(
      {required SearchType searchType,
      String? keyword,
      Category? category}) async {
    //todo あとで使うからコンストラクタ
    http.Response? response;
    print(
        "[repository]search/$searchType/key$keyword/cate/${category!.nameJp}");
    switch (searchType) {
      case SearchType.HEAD_LINE:
        final requestUrl = Uri.parse(BASE_URL + "&apiKey=$API_KEY");
        response = await http.get(requestUrl);
        break;
      case SearchType.KRYWORD:
        //todo パラメータを重ねる時は＆を使う
        final requestUrl = Uri.parse(BASE_URL + "&q=$keyword&apiKey=$API_KEY");
        response = await http.get(requestUrl);
        break;
      case SearchType.CATEGORY:
        final requestUrl = Uri.parse(
            BASE_URL + "&category=${category.nameEn}&apiKey=$API_KEY");
        response = await http.get(requestUrl);
        break;
    }
  }
}
