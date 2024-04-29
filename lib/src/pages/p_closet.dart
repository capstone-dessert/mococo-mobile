import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';
import '../widgets/image_list.dart';
import '../widgets/tag_list.dart';

class Closet extends StatelessWidget {
  const Closet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(),
      body: Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: const TagviewPage()),
    );
  }
}
