import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  final ValueChanged onSearch;

  SearchBar({required this.onSearch});



  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(const Radius.circular(24))
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: TextField(
          onSubmitted: onSearch,
          maxLines: 1,
          controller: _textEditingController,
          decoration: InputDecoration(
            icon: Icon(Icons.search),
            hintText: "検索ワードを入れてください",
            border: InputBorder.none
          ),
        ),
      ),
    );
  }
}
