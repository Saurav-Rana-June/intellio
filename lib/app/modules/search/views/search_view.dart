import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_controller.dart' as search;

class SearchView extends GetView<search.SearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('gjgjgjjg', style: TextStyle(fontSize: 20),),
      ),
    );
  }
}
