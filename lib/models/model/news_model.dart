import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
class News {
  final List<Article> articles;
  News({required this.articles});
  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);
}

@JsonSerializable()
class Article {
  @JsonKey(name: "publishedAt")final String publishDate;
  final String? urlToImage;
  final String? content;
  final String? title;
  final String? url;
  final String? description;

  Article({required this.title,required this.description,required this.url,required this.urlToImage,required this.publishDate,required this.content});

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}