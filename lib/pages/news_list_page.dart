import 'package:flutter/material.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/view/components/category_chips.dart';
import 'package:news_feed/view/components/search_bar.dart';
import 'package:news_feed/viewmodels/news_list_view_model.dart';
import 'package:provider/provider.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          tooltip: "更新",
          onPressed: () => onRefresh(context),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //todo
              SearchBar(
                  onSearch: (keyword) => getKeywordNews(context, keyword)),
              // //todo
              CategoryChips(
                onCategorySelected: (category) =>
                    getCategoryNews(context, category),
              ),
              //todo
              Expanded(child: Center(child: CircularProgressIndicator())),
            ],
          ),
        ),
      ),
    );
  }

  //todo 記事更新処理
  onRefresh(BuildContext context) {
    final viewModel = context.read<NewsListViewModel>();
    viewModel.getNews(searchType: viewModel.searchType,
    keyword: viewModel.keyword,
    category: viewModel.category);
    print("あああ");
  }

  //todo キーワード記事取得処理
  getKeywordNews(BuildContext context, keyword) {
    final viewModel = context.read<NewsListViewModel>();
    viewModel.getNews(
        searchType: SearchType.KEYWORD,
        keyword: keyword,
        category: categories[0]);
    SearchType type = SearchType.CATEGORY;
    print(keyword);
  }

  //todo カテゴリー記事取得処理
  getCategoryNews(BuildContext context, Category category) {
    final viewModel = context.read<NewsListViewModel>();
    viewModel.getNews(searchType: SearchType.CATEGORY,category: category);
    print("category${category.nameJp}");
  }
}
