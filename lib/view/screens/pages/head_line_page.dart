import 'package:flutter/material.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/viewmodels/head_line_view_model.dart';
import 'package:provider/provider.dart';

class HeadLinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HeadLineViewModel>(context,listen: false);

    if(!viewModel.isLoading && viewModel.articles.isEmpty){
      Future(() => viewModel.getHeadLines(searchType: SearchType.HEAD_LINE));
    }
    return Scaffold(
      //todo なぜ３つのコンストラクタが必要なの？
      body: Consumer<HeadLineViewModel>(
        builder: (context,model,child){
          return PageView.builder(
            controller: PageController(),
            itemCount: model.articles.length,
            itemBuilder: (context,index){
              final article = model.articles[index];
              return Container(
              child: Center(
                child: Column(
                  children:<Widget>[
                    Text(article.title ?? ""),
                    Text(article.description ?? "")
                  ],
                ),
              ),
            );
          },);
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => onRefresh(context),
      ),
    );
  }

  onRefresh(BuildContext context) async{
    print("アイウエオ");
    final viewModel = Provider.of<HeadLineViewModel>(context,listen: false);
    await viewModel.getHeadLines(searchType: SearchType.HEAD_LINE);
  }
}
