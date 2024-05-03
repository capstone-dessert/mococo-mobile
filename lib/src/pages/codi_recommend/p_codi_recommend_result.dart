import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';

class CodiRecommendResult extends StatefulWidget {
  const CodiRecommendResult({super.key});

  @override
  State<CodiRecommendResult> createState() => _CodiRecommendResultState();
}

class _CodiRecommendResultState extends State<CodiRecommendResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextTitleAppBar(
        title: "테스트",
        buttonNum: 2,
        onBackButtonPressed: _onBackButtonPressed,
        onEditButtonPressed: _onEditButtonPressed,
        onDeleteButtonPressed: _onDeleteButtonPressed,
      ),
      body: const Center(child: Text('코디 추천 결과'),
      ),
    );
  }

  void _onBackButtonPressed() {
    Navigator.pop(context);
  }

  void _onEditButtonPressed() {
    print("Edit");
  }

  void _onDeleteButtonPressed() {
    print("Delete");
  }
}
