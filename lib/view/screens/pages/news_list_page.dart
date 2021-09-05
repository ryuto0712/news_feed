import 'package:flutter/material.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/view/components/article_tile.dart';
import 'package:news_feed/view/components/category_chips.dart';
import 'package:news_feed/view/components/search_bar.dart';
import 'package:news_feed/viewmodels/news_list_viewmodel.dart';
import 'package:provider/provider.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    //todo ローディングしてなくて、記事が１つもない時
    if (!viewModel.isLoading && viewModel.articles.isEmpty){
      Future(() => viewModel.getNews(searchType: SearchType.CATEGORY,category: categories[0]));
    }




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
            CategoryChips(onCategorySelected: (category) => getCategoryNews(context,category),),
            Expanded(child: Consumer<NewsListViewModel>(
                builder: (context,model,child){
                  return model.isLoading
                      ? Center(
                    child: CircularProgressIndicator(),
                  )
                    : ListView.builder(itemCount: model.articles.length,
                    itemBuilder: (context, int position)
                    => ArticleTile(article: model.articles[position], onArticleClicked: (article) => _openArticleWebPage(article,context))
                  );
                })),
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
  Future<void>getCategoryNews(BuildContext context, Category category) async{
    print("NewsListPage.getCategoryNews / category: ${category.nameJp}");
    final viewModel = Provider.of<NewsListViewModel>(context,listen:false);
    await viewModel.getNews(searchType: SearchType.CATEGORY,category: category);

  }

  _openArticleWebPage(article, BuildContext context) {
    print("${article.url}");
  }
}
