import 'dart:convert';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:http/http.dart' as http;
import 'package:news_feed/models/model/news_model.dart';

class NewsRepository {
  static const BASE_URL = "https://newsapi.org/v2/top-headlines?country=js";
  static const API_KEY = "427ede87c3774c88ba1d372e0293abe5";

//todo 現時点ではarticleを作成してないのでエラー
  //todo 戻り値を設定する理由は戻り値によって、変更を返すため
  Future<List<Article>> getNews(
      {required SearchType searchType,
      String? keyword,
      Category? category}) async {
    List<Article> result = [];
    //todo あとで使うからコンストラクタ
    http.Response? response;
    print(
        "[repository]search/$searchType/key$keyword/cate/${category!.nameJp}");
    switch (searchType) {
      case SearchType.HEAD_LINE:
        print("NewsRepository.getHeadLines");
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

    if(response.statusCode == 200){
      final responseBody = response.body;
      result = News.fromJson(jsonDecode(responseBody)).articles;
    }else{
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }

    return result;

  }
}
