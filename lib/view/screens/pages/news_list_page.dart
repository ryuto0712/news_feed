import 'package:flutter/material.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/view/components/category_chips.dart';
import 'package:news_feed/view/components/search_bar.dart';
import 'package:news_feed/viewmodels/news_list_viewmodel.dart';
import 'package:provider/provider.dart';

class NewsListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        tooltip: "更新",
        onPressed: () => onRefresh(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
            SearchBar(onSearch: (keyword) => getKeywordNews(context,keyword),),
            CategoryChips(onCategorySelected: (category) => getCategoruNews(context,category),),
            Expanded(child: Center(child: CircularProgressIndicator())),
          ],
        ),
      ),
    );
  }
  //todo
  Future<void>onRefresh(BuildContext context) async{
    final viewModel = Provider.of<NewsListViewModel>(context,listen:false);
    await viewModel.getNews(searchType: viewModel.searchType,keyword: viewModel.keyword,category: viewModel.category);
    print("リフレ");
  }
 //todo
  Future<void>getKeywordNews(BuildContext context, keyword) async{
    final viewModel = Provider.of<NewsListViewModel>(context,listen:false);
    await viewModel.getNews(searchType: SearchType.KRYWORD,keyword: keyword,category: categories[0]);
    print("keyword取得");
  }
  //todo
  Future<void>getCategoruNews(BuildContext context, Category category) async{
    print("${category.nameJp}");
    final viewModel = Provider.of<NewsListViewModel>(context,listen:false);
    await viewModel.getNews(searchType: SearchType.CATEGORY,category: category);

  }
}
