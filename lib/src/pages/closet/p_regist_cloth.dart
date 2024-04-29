import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/tag_list.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BaseAppBar(),
      body: Column(
        children: [
          Flexible(
            flex: 1, // 첫 번째 페이지의 비율
            child: CatTagviewPage(),
          ),
          Flexible(
            flex: 1, // 두 번째 페이지의 비율
            child: ColorTagviewPage(),
          ),
        ],
      ),
    );
  }
}
