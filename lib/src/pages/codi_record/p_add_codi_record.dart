import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/editable_date.dart';
import 'package:mococo_mobile/src/widgets/editable_weather.dart';

class AddCodiRecord extends StatefulWidget {
  const AddCodiRecord({super.key});

  @override
  State<AddCodiRecord> createState() => _AddCodiRecordState();
}

class _AddCodiRecordState extends State<AddCodiRecord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextTitleAppBar(title: "코디 기록", buttonNum: 3, onBackButtonPressed: _onBackButtonPressed, onSaveButtonPressed: _onSaveButtonPressed,),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                EditableDate(isCenter: false,),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onBackButtonPressed() {

  }

  void _onSaveButtonPressed() {

  }
}
