import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';

class CodiRecommendResult extends StatelessWidget {
  const CodiRecommendResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextTitleAppBar(
        title: "테스트",
        buttonNum: 2,
        onEditButtonPressed: _onEditButtonPressed,
        onDeleteButtonPressed: _onDeleteButtonPressed,
      ),
      body: const Center(child: Text('코디 추천 결과'),
      ),
    );
  }

  void _onEditButtonPressed() {
    print("Edit");
  }

  void _onDeleteButtonPressed() {
    print("Delete");
  }
}
