import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        title: "추천 코디",
        buttonNum: 3,
        onBackButtonPressed: _onBackButtonPressed,
        onSaveButtonPressed: _onSaveButtonPressed,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
      )
    );
  }

  void _onBackButtonPressed() {
    Navigator.pop(context);
  }

  void _onSaveButtonPressed() {
    print("Save");
  }
}
