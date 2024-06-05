import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/new_tag_picker.dart';
import 'package:mococo_mobile/src/widgets/new_tag_pickers.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  Map<String, dynamic> selectedInfo = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CenterLogoAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TagPicker(setSelectedInfo: setSelectedInfo,),
              OutlinedButton(
                onPressed: () {
                },
                child: Text("button")
              )
            ],
          ),
        ),
      )
    );
  }

  void setSelectedInfo(Map<String, dynamic> newSelectedInfo) {
    selectedInfo = newSelectedInfo;
  }
}
