import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components/image_data.dart';
import '../../components/image_data.dart';
import '../../widgets/app_bar.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TextTitleAppBar(title: "의류 등록", buttonNum: 3, onSaveButtonPressed: _onSaveButtonPressed,),
      body: Stack(
        children: [
          const SizedBox(
            height: 30,
          ),
          //사진
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                child: Image.asset(IconPath.topSample),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _onSaveButtonPressed() {

  }
}
