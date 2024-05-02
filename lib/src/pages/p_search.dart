import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/tag_list.dart';
import '../controller/app_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TextTitleAppBar(
          title: '검색',
          buttonNum: 0,
        ),
        body: SingleChildScrollView());
  }
}
